#set page(
  paper: "us-letter",
  margin: 1.25cm,
)

#set text(
  font: "Libertinus Serif",
  size: 10pt,
  hyphenate: false,
)

// Reduced list spacing and paragraph leading to make everything denser
#set list(
  spacing: 4pt,
)

#set par(
  leading: 4.5pt,
  justify: true,
)

#show heading.where(level: 1): it => block(width: 100%)[
  #v(2pt)
  #set align(left)
  #set text(font: "Libertinus Serif", size: 1.2em, weight: "bold")
  #upper(it.body)
  #v(-1em) #line(length: 100%, stroke: 1pt + black)
]

#show heading.where(level: 2): it => block(width: 100%)[
  #v(1.5pt)
  #set align(left)
  #set text(font: "Libertinus Serif", size: 11pt, weight: "bold", style: "normal")
  #it.body
]

#show heading.where(level: 3): it => block(width: 100%, above: 5pt, below: 3pt)[
  #set align(left)
  #set text(font: "Libertinus Serif", size: 10pt, weight: "bold", style: "italic", fill: rgb("#881337"))
  #it.body
]

#show link: set text(fill: rgb("#881337"))

#align(center)[
  #v(-15pt)
  #set text(font: "Libertinus Serif", size: 18pt, weight: "bold")
  Alfu Nikmatul Laily, B.Nutr, PhD.
  #v(-16pt)
  #set text(weight: "medium", size: 10pt)
  #pad(x: 0em)[
    #link("mailto:alfu.n.laily@gmail.com")[alfu.n.laily\@gmail.com]
    #sym.space.en #sym.diamond.filled #sym.space.en
    #link("https://www.linkedin.com/in/alfu-laily/")[linkedin.com/in/alfu-laily/]
  ]
]

// Drastically reduced the "below" spacing to make all normal sections globally denser
#let cv_entry(date, title, subtitle, description) = {
  block(width: 100%, breakable: true, below: 0.3em)[
    #if title != "" and subtitle != "" [
      #strong[#title] \
      #emph[#subtitle] #h(1fr) #date
    ] else if title != "" and subtitle == "" [
      #strong[#title] #h(1fr) #date
    ] else if title == "" and subtitle != "" [
      #emph[#subtitle] #h(1fr) #date
    ] else [
      #h(1fr) #date
    ]
    #if description != "" and description != [] [
      #description
    ]
  ]
}

// Unified layout helper function to guarantee alignment and tight spacing for gray/white sections
#let gray_cv_entry(date, title, subtitle, description, is_gray) = {
  let bg = if is_gray { luma(245) } else { none }
  block(fill: bg, inset: (x: 4pt, y: 2pt), outset: 0pt, width: 100%, radius: 2pt, below: 0.2em, breakable: false)[
    #if title != "" and subtitle != "" [
      #strong[#title] \
      #emph[#subtitle] #h(1fr) #date
    ] else if title != "" and subtitle == "" [
      #strong[#title] #h(1fr) #date
    ] else if title == "" and subtitle != "" [
      #emph[#subtitle] #h(1fr) #date
    ] else [
      #h(1fr) #date
    ]
    #if description != "" and description != [] [\ #description]
  ]
}

// Renders each numbered/bulleted list item as an alternating gray/white block (same look as gray_cv_entry)
#let striped_list(it) = {
  let numbered = it.func() == enum
  for (i, item) in it.children.enumerate() {
    let marker = if numbered {
      let n = if item.has("number") and type(item.number) == int { item.number } else { i + 1 }
      [#n.]
    } else { [•] }
    block(
      fill: if calc.even(i) { luma(245) } else { none },
      inset: (x: 4pt, y: 2pt),
      outset: 0pt,
      width: 100%,
      radius: 2pt,
      above: 0.2em,
      below: 0.2em,
      breakable: true,
      grid(
        columns: (1.4em, 1fr),
        column-gutter: 0.5em,
        align(right, marker), item.body,
      ),
    )
  }
}

= EDUCATION

#cv_entry(
  "1/2021 - 8/2025",
  [Purdue University, West Lafayette, Indiana, USA #h(1fr) 4.00/4.00 | PhD],
  "Department of Public Health / Major: Public Health",
  [
    \
    Research areas: infection-related cancer prevention, large language models for health communication, rural-urban health equity, vaccine hesitancy, equity in women's health, diet and infection-related cancers. \
    Dissertation: Examining Factors Associated with Human Papillomavirus Vaccine Hesitancy in Adult Populations: From Religious Aspects to Online Information Quality. \
    _Supervisor:_ Dr. Monica Kasting, PhD.
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "8/2012 - 7/2016",
  [Universitas Indonesia, Depok, West Java, Indonesia #h(1fr) 3.62/4.00 | B.Nutr],
  "Department of Public Health Nutrition / Major: Nutrition of Public Health",
  [
    \
    Bachelor thesis: Semi-Randomized Controlled Trials of Contento's Theory-based Nutrition Education on Adult Caloric Intake Reduction. \
    _Supervisor:_ Prof. Dr. drg. Sandra Fikawati, M.PH.
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "7/2010 - 8/2012",
  [State Senior High School 1 Tuban, East Java, Indonesia #h(1fr) 9.11/10.00],
  "Major: Natural Science - acceleration class (2 years high school)",
  [],
)

= PROFESSIONAL POSITIONS

#cv_entry(
  "8/2025 - 8/2027",
  "Purdue University - School of Nursing",
  "Postdoctoral Researcher",
  [
    - Developing and evaluating a #underline[mobile health (mHealth)] intervention to promote health equity in latent tuberculosis infection self-management among #underline[Haitian migrants] in Indiana.
    - Investigating #underline[inequities in maternal vaccine] information sources, information trust, vaccine hesitancy, and vaccine uptake among pregnant women in Indiana, with a focus on #underline[rural communities].
    - Investigating health consumers' perceptions and knowledge of the human papillomavirus vaccine through #underline[qualitative analysis of social media data].
    - Analyzing the role of #underline[health literacy in hepatitis C virus] knowledge to inform screening and prevention strategies.
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "8/2021 - 8/2025",
  "Purdue University - Public Health Department",
  "Research Assistant",
  [
    - Evaluated information quality generated by #underline[large language models] in providing human papillomavirus (HPV) vaccine-related information.
    - Explored psychosocial factors associated with #underline[HPV vaccine hesitancy] in adults.
    - Analyzed #underline[vaccine deliveries by community paramedics] to reduce vaccine hesitancy in Indiana rural communities.
    - Investigated #underline[health equity of uterine fibroid care] among women in Indiana.
    - Investigated healthcare providers' #underline[practices regarding Hepatitis C Virus] (HCV) screening recommendations for all adults to ensure equity in care.
    - Developed and conducted #underline[feasibility testing for a multilevel intervention] aimed at increasing Hepatitis C Virus screening equity for all in primary care.
    - Examined ecological factors influencing shared decision-making in #underline[women's reproductive healthcare].
    - Explored the relationship between #underline[inflammatory diets and infection-related cancers].

    _Professional positions held while being a doctoral student:_ \
    *Teaching Assistant* \
    PUBH 400 (Human Diseases and Disorders), PUBH 320 (Health Behavior and Health Promotion), PUBH 601 (Introduction to The Quantitative Methods of Public Health), and PUBH 606 (Design and Analysis of Public Health Interventions).
    - Graded students' weekly assignments.
    - Prepared learning platform materials.
    - Performed office hours and occasionally taught classes.
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "7/2016 - 5/2019",
  "Female Cancer Program (Leiden University - Universitas Indonesia - Cipto Mangunkusumo Central National Hospital)",
  "Research Manager (2016-2017) and Center of Excellence Co-Manager (2017-2019)",
  [
    - Managed community research from #underline[writing grant proposals to publishing] in conferences and international journals.
    - Managed the pilot area for independent #underline[cervical cancer prevention and management], with the goal of #underline[empowering women] with low economic status to access care.
    - Developed a #underline["See and Treat" model] to reduce cervical cancer incidence in developing countries.
    - Co-created a #underline[smartphone-based application] to manage cervical cancer patient care.
    - Chaperoned international guests for field visits and #underline[regional program expansions].

    _A multinational NGO based in the Netherlands, focused on reducing the prevalence of cervical cancer in developing countries._
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "7/2017 - 9/2018",
  "Indonesian Medical Association - Indonesian Ministry of State Secretariat",
  "Head's Assistant of Presidential National Resolution (Health Sector)",
  [
    - Collaborated with a #underline[national team] to design equitable solutions for current national health challenges.
    - Drafted resolutions for equitable national health problem solutions to be presented directly to the #underline[President of the Republic of Indonesia].
    - Organized national conferences to gather #underline[resolution inputs from the grassroots level], giving voice to marginalized communities and ensuring equity.

    _A national evaluation program mandated by the President of Indonesia, dedicated to resolving systemic health challenges through equitable solutions._
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "10/2016 - 6/2017",
  "Indonesian Medical Association",
  "White Paper Editor",
  [
    - Conducted comprehensive #underline[literature reviews and field data synthesis] to support white paper motion.
    - Facilitated collaborative review cycles with #underline[distinguished academic leaders] to validate and enhance the quality of the report and statements.
    - Managed the end-to-end development of the white paper, translating complex concepts into #underline[actionable policy recommendations] for the Presidential Commission.

    _IMA's official statement in response to new health policies for Indonesian Presidential Commission discussion._
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "10/2015 - 12/2015",
  "Faculty of Public Health, Universitas Indonesia",
  "Community Nutritionist",
  [
    - Identified, gathered, and analyzed health data within the community to define highest prevalence of #underline[nutritional problems] in the village.
    - Designed community-specific media for #underline[health promotion] tailored to the characteristics of the community.
    - Conducted community education and served as a #underline[personal nutrition consultant] for individuals of all ages.

    _A nutritionist internship in a community setting at Bojongsari Village, West Java, Indonesia._
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "8/2015 - 10/2015",
  "Cipto Mangunkusumo Central National Hospital (RSCM)",
  "Clinical Nutritionist",
  [
    - Implemented the #underline[Nutrition Care Process] (NCP) for patients, including identification, analysis, and education.
    - Conducted #underline[quantitative research] related to nutrition issues in the hospital.
    - Studied #underline[food flow management], including receiving, sorting, cooking, and food presentation.
    - Collaborated with other healthcare professionals (doctors, other nutritionists, pharmacists, and nurses) to formulate medical treatment meals for patients.

    _A nutritionist internship in a hospital setting._
  ],
)
#v(0em) #line(length: 100%, stroke: 0.5pt + luma(220))
#cv_entry(
  "06/2015 - 08/2015",
  "Indonesian Ministry of Health (Communicable Diseases Sector)",
  "Data Entry Specialist",
  [
    - Entered data (3500 exemplars \@ 25 pages each) into Epidata software.

    _Data entry of national-scale questionnaires related to sexually transmitted diseases._
  ],
)

= AWARDS

#gray_cv_entry(
  "2026",
  "Rising Star Award",
  "HIV & Sexual Health Special Interest Group, Society of Behavioral Medicine, 47th Annual Meeting, Chicago, IL, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2026",
  "Best PhD/Postdoc Poster",
  "Helen R. Johnson Leadership Conference, Purdue University, West Lafayette, IN, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2026",
  "Postdoctoral Supplemental Travel Award",
  "Office of the Vice Provost for Graduate Students and Postdoctoral Scholars, Purdue University, West Lafayette, IN, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2025",
  "Diversity, Equity and Inclusion (DEI) Travel Award",
  "Cancer Special Interest Group, Society of Behavioral Medicine, 46th Annual Meeting, San Francisco, CA, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2024",
  "Recognition of Stellar Graduate Student for High-Profile Works",
  "President Mung Chiang, Purdue University, West Lafayette, IN, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2024",
  "Honorable Mention for Student Research Award",
  "Health Equity Special Interest Group, Society of Behavioral Medicine, 45th Annual Meeting, Philadelphia, PA, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2024",
  "Distinguished Student Travel Scholarship",
  "Society of Behavioral Medicine, 45th Annual Meeting, Philadelphia, PA, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2024",
  "Cancer Prevention and Control Small Dollar Fund",
  "Comprehensive Cancer Center, Indiana University, Bloomington, IN, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2023",
  "Outstanding Public Health Student",
  "Indiana Public Health Association, Indianapolis, IN, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2023",
  "Compton Graduate Student Research Travel Award",
  "College of Health and Human Sciences, Purdue University, West Lafayette, IN, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2023",
  "Seed Funding for Books, Monographs and High-Impact Review Paper ($10,000)",
  "College of Health and Human Sciences, Purdue University, West Lafayette, IN, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2023",
  "First Place of Graduate Student Poster Award",
  "Women's Global Health Institute, West Lafayette, IN, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2023-24",
  "International Peace Scholarship Award",
  "Philanthropic Educational Organization, Des Moines, IA, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2023",
  "Best Graduate/Postdoc Research",
  "Integrated Primary Care Special Interest Group, Society of Behavioral Medicine, 44th Annual Meeting, Phoenix, AZ, USA.",
  "",
  false,
)
#gray_cv_entry(
  "2023",
  "Second Place of Graduate Students Poster Award",
  "Purdue Health and Human Sciences Research Symposium, West Lafayette, IN, USA.",
  "",
  true,
)
#gray_cv_entry("2023", "Purdue Graduate Travel Award", "Purdue University, West Lafayette, IN, USA.", "", false)
#gray_cv_entry(
  "2022",
  "Compton Graduate Student Research Travel Award",
  "College of Health and Human Sciences, Purdue University, West Lafayette, IN, USA.",
  "",
  true,
)
#gray_cv_entry(
  "2016",
  "Best Paper, International Conference on Medical and Health Sciences",
  "International Society for Engineering Research and Development, ICMHS Conference, Seoul, South Korea.",
  "",
  false,
)
#gray_cv_entry(
  "2016",
  "Rector's Appreciation for Winners in the Republic of Indonesia Government Competition",
  "Universitas Indonesia, Depok, West Java, Indonesia.",
  "",
  true,
)
#gray_cv_entry(
  "2016",
  "Gold Medal: 29th National Scientific Student Summit (29th Pekan Ilmiah Mahasiswa Nasional-PIMNAS)",
  "Ministry of Research, Technology and Higher Education of Republic Indonesia, Bogor, West Java, Indonesia.",
  "",
  false,
)
#gray_cv_entry(
  "2016",
  "Rector Appreciation for Cum Laude Undergraduates",
  "Universitas Indonesia, Depok, West Java, Indonesia.",
  "",
  true,
)
#gray_cv_entry(
  "2016",
  "Appreciation for Registered Patent Right",
  "Innovation and Business Incubator Directorate, Universitas Indonesia, Depok, West Java, Indonesia.",
  "",
  false,
)
#gray_cv_entry(
  "2014",
  "The Most Outstanding Student (Science Category)",
  "Nutrition Family Association Universitas Indonesia, Depok, West Java, Indonesia.",
  "",
  true,
)

= PUBLICATIONS

#[
  #show enum: striped_list
  #show list: striped_list
  #show regex("( |-)20\d{2}\b"): it => [#it.text.at(0)#strong[#it.text.slice(1)]]

== PEER-REVIEWED JOURNAL ARTICLES

=== Under review
1. Jo S, *Laily A*, Brown JL, Sullender K, Holsopple M, Elizaire P. Development of a Tuberculosis Prevention Intervention for Haitian Migrants Using Intervention Mapping and Community-Based Participatory Research. West. J. Nurs. Res. 2026. Under review.
2. *Laily A*, Jo S. Defining Latent Tuberculosis Infection Self-Management: A Concept Analysis. Public Health Nurs. 2026. Under review.
3. Jo S, *Laily A*, Xu D. Information Channels, Relevant Channel Beliefs, and Human Papillomavirus Awareness in a Rural Indiana Population. Cancer Nurs. 2026. Under review.
4. *Laily A*, Jo S. Do Americans Know that Hepatitis C Virus can Cause Cancer? A Cross-sectional Study Examining Hepatitis C Virus Knowledge and Health Literacy. Health Info Libr J. 2026. Under review.
5. *Laily A*, Duncan R, Hubach RD, LaRoche KJ, Rodriguez NM, Zimet GD, Kasting ML. Faith and Immunity: Exploring the Association of Religious Factors on Human Papillomavirus Vaccine Uptake Among Indiana Adults. Vaccine. 2026. Under review.
6. *Laily A*, Reed JB, Powers MQ, Giuliano AR, Kasting ML. The Association between Inflammatory Diet and Infection-Related Cancers in Adults: A Systematic Review. Cancer Epidemiol Biomarkers Prev. 2026. Under review.
7. Tasnim R, *Laily A*, Head KJ, Zimet GD, Schwab-Reese LM, Kasting ML. Comparing public perceptions of community paramedics and physicians: A cross-sectional study. J Gen Intern Med. 2026. Under review.

=== Published
1. *Laily A*, Jo S, Xu D, Coddington JA. Trust in Vaccine Information Sources, Perceived Message Credibility, Healthcare Provider Recommendations, and Influenza Vaccine Hesitancy and Uptake Among Rural Adults in Indiana. J. Community Health Nurs. 2026. #link("https://doi.org/10.1080/07370016.2026.2754469")[doi: 10.1080/07370016.2026.2754469]
2. *Laily A*, Schwab-Reese L, Head KJ, Zimet GD, Kasting ML. Exploring Non-metropolitan/Metropolitan Disparities in Vaccination Confidence and Uptake among Adults in Indiana. Vaccine X. 2026; 30:100820. #link("https://doi.org/10.1016/j.jvacx.2026.100820")[doi: 10.1016/j.jvacx.2026.100820]
3. *Laily A*, Schwab-Reese L, Davish M, Cahue E, LaRoche KJ, Rodriguez NM, Duncan R, Hubach RD, Kasting ML. Examining Artificial Intelligence Chatbots' Responses in Providing Human Papillomavirus Vaccine Information for Young Adults. JMIR Public Health Surveill. 2026; 12:e79720. #link("https://doi.org/10.2196/79720")[doi: 10.2196/79720]
4. *Laily A*, Jo S, Duncan R, Hubach RD, LaRoche KJ, Rodriguez NM, Kasting ML. Human Papillomavirus Awareness in a Digital World: The Intersection of Faith and Online Media. Prev Med Rep. 2025; 58:103241. #link("https://doi.org/10.1016/j.pmedr.2025.103241")[doi: 10.1016/j.pmedr.2025.103241]
5. Kasting ML, *Laily A*, Smith SH, Sembian S, Head KJ, Usidame B, Zimet GD, Schwab Reese LM. Exploring the Feasibility and Acceptability of Community Paramedicine Programs in Achieving Vaccination Equity: A Qualitative Study. BMC Health Serv Res. 2024; 24:1022. #link("https://doi.org/10.1186/s12913-024-11422-0")[doi: 10.1186/s12913-024-11422-0]
6. Kasting ML, *Laily A*, Burney HN, Head KJ, Daggy JK, Zimet GD, Schwab-Reese LM. County-Level Factors Associated with Influenza and COVID-19 Vaccination in Indiana, 2020-2022. Am J Public Health. 2024; 114(4):415-423. #link("https://doi.org/10.2105/AJPH.2023.307553")[doi: 10.2105/AJPH.2023.307553]
7. *Laily A*, Duncan R, Gabhart KM, Nephew LD, Christy SM, Vadaparampil ST, Giuliano AR, Kasting ML. Differences in Provider Hepatitis C Virus Screening Recommendations by Patient Risk Status. Prev Med Rep. 2024; 38:102602. #link("https://doi.org/10.1016/j.pmedr.2024.102602")[doi: 10.1016/j.pmedr.2024.102602]
8. *Laily A*, Nair I, Shank S, Khamis G, Kelly C, Dykstra C, DeMaria AL, Kasting ML. Enhancing Uterine Fibroid Care: Clinician Perspectives on Diagnosis, Disparities, and Strategies for Improving Health Care. Womens Health Rep. 2024; 5(1):293-304. #link("https://doi.org/10.1089/whr.2023.0113")[doi: 10.1089/whr.2023.0113]
9. Dykstra C, *Laily A*, Marsh EE, Kasting ML, DeMaria AL. "I think people should be more aware:" Uterine fibroid experiences among women living in Indiana, USA. Patient Educ Couns. 2023; 107:107584. #link("https://doi.org/10.1016/j.pec.2022.107584")[doi: 10.1016/j.pec.2022.107584]
10. Kasting ML, *Laily A*, Nephew LD, Shields CG, Shedd-Steele R, Rawl SM. Development and Feasibility Testing of A Multilevel Intervention to Increase Hepatitis C Virus Screening among Baby Boomers In Primary Care. J Cancer Educ. 2023; 38(2):718-729. #link("https://doi.org/10.1007/s13187-023-02268-x")[doi: 10.1007/s13187-023-02268-x]
11. Meier S, *Laily A*, Schwab Reese L, Kasting ML, DeMaria AL. An Exploratory Model of Shared Decision-Making in Women's Reproductive Health in Indiana: A Cross-Sectional Study. Health Behav Res. 2023; 6(2). #link("https://doi.org/10.4148/2572-1836.1181")[doi: 10.4148/2572-1836.1181]
12. Nuranna L, Fatahan N, *Laily AN*, Purwoto G. Knowledge and behavior of Indonesian general practitioners on cervical cancer early detection. Majalah Obstetri dan Ginekologi. 2020; 28(1):20-23. #link("https://doi.org/10.20473/mog.V28I12020.20-23")[doi: 10.20473/mog.V28I12020.20-23]
13. Nuranna L, Fatahan N, *Laily AN*. Case Series: Cryotherapy versus Cold Coagulation as Cervical Pre-Cancer Lesion Treatment. Indonesian Journal of Obstetrics and Gynecology. 2019; 7(4). #link("https://doi.org/10.32771/inajog.v7i4.1141")[doi: 10.32771/inajog.v7i4.1141]
14. Nuranna L, Antonius PA, *Laily AN*, Kusuma F, Nuryanto KH. IIIB-plus: A new classification recommended for stage IIIB cervical cancer patients with renal impairment. J Nat Sci Biol Med. 2019; 10:S113-7. #link("https://doi.org/10.4103/jnsbm.JNSBM_53_19")[doi: 10.4103/jnsbm.JNSBM_53_19]
15. Nuranna L, Fatahan N, Puspitasari HD, *Laily AN*, Winarto H, Utami TW, Anggraeni TD, Nuryanto HK, Purwoto G. Efficacy of Cryotherapy for Cervical Precancer Lesion Treatment in Jatinegara Primary Health Care, 2016. Adv Sci Lett. 2018; 24(9):6554-6557. #link("https://doi.org/10.1166/asl.2018.12776")[doi: 10.1166/asl.2018.12776]
16. Nuranna L, Purwoto G, Khairani Y, *Laily AN*, Narayani IA. See and Treat Model: Attempt in Resolving Cervical Cancer in Developing Country. Adv Sci Lett. 2017; 23:6871-74. #link("https://doi.org/10.1166/asl.2017.9420")[doi: 10.1166/asl.2017.9420]
17. *Laily AN*. Nutrient profiling: Role in Public Health. Berkala Ilmiah Mahasiswa Gizi Indonesia. 2016;4(1).

  == CONFERENCE PRESENTATIONS
1. *Laily A*, Hass Z, Brown JL, Jo S. Pregnant Women's RSV Vaccination Hesitancy: Information, Trust, and Health Beliefs. Podium presentation at Southern Nursing Research Society 41st Annual Conference; February 2027; Atlanta, GA.
2. Jo S, Brown JL, *Laily A*. Development of a Culturally Adapted Tuberculosis Prevention Intervention in Rural Areas: A Community-Based Participatory Research Approach. Poster presentation at American Public Health Association (APHA) 2026 Annual Meeting and Expo; November 1-4, 2026; San Antonio, TX.
3. Jo S, *Laily A*, Kim Y, Brown JL, Sullender K, Holsopple M, Stefancik J, Elizaire P. Development of a Mobile Health Application for Latent Tuberculosis Self-Management: A Community Engaged Approach. Poster presentation at American Medical Informatics Association Annual Symposium; November 2026; Dallas, Tx.
4. *Laily A*, Schwab-Reese L, Davish M, Cahue E, LaRoche KJ, Rodriguez NM, Duncan R, Hubach RD, Kasting ML. Examining Artificial Intelligence Chatbots' Responses in Providing Human Papillomavirus Vaccine Information for Young Adults. Poster presented at: Society of Behavioral Medicine 47th Annual Meeting; April 2026; Chicago, IL.
5. *Laily A*, Jo S. Who Do Rural Communities Trust? The Role of Information Sources in Human Papillomavirus Vaccination Uptake in Rural Indiana. Poster presented at: Society of Behavioral Medicine 47th Annual Meeting; April 2026; Chicago, IL.
6. *Laily A*, Jo S. Development of a Mobile Health Application for Equity-Centered Latent Tuberculosis Self-Management Among the Rural Haitian Population in Daviess County, Indiana. Poster presented at: 2026 Helen R. Johnson Leadership Conference; April 2026; West Lafayette, IN.
7. Ramkumar S, Jo S, *Laily A*. Ethnic Identity and the Use of Pap Smear Tests among Asian American Women: A Proposal using the Health Information National Trends Survey (HINTS). Poster presented at 2026 Helen R. Johnson Leadership Conference; April 2026; West Lafayette, IN.
8. Amin I, Jo S, *Laily A*. Perceived Channel Beliefs of Mass and Social Media and Human Papillomavirus Vaccine Uptake Among Rural Indiana Residents. Poster presented at Purdue University Spring Undergraduate Research Conference; April 2026; West Lafayette, IN.
9. *Laily A*, Jo S. Development of a Mobile Health Application for Equity-Centered Latent Tuberculosis Self-Management Among the Rural Haitian Population in Daviess County, Indiana. Poster presented at: Purdue's One Health and Well-Being Research Event; March 2026; West Lafayette, IN.
10. *Laily A*, Duncan R, Hubach RD, LaRoche KJ, Rodriguez NM, Zimet GD, Kasting ML. Faith and Immunity: Exploring the Association of Religious Factors on HPV Vaccine Uptake Among Indiana Adults. Poster presented at: Society of Behavioral Medicine 46th Annual Meeting; March 2025; San Francisco, CA.
11. *Laily A*, Zimet GD, Schwab-Reese LM, Head KJ, Kasting ML. Exploring Confidence and Uptake Disparities in Adult Vaccinations Across Rural and Urban Indiana. Oral presentation at: American Public Health Association 2024 Annual Meeting and Expo; October 2024; Minneapolis, MN.
12. *Laily A*, Schwab-Reese LM, Smith S, Sembian S, Head KJ, Zimet GD, Kasting ML. Bridging Disparities: Exploring the Role of Community Paramedicine Programs in Achieving Vaccination Equity in Urban-Rural Settings. Poster presented at: Society of Behavioral Medicine 45th Annual Meeting; March 2024; Philadelphia, PA.
13. Kasting ML, *Laily A*, Head KJ, Usidame B, Zimet GD, Schwab Reese LM. A novel use of Community Paramedicine to Address Rural/Urban HPV Vaccination Disparities. Poster presented at: American Society of Preventive Oncology 48th Annual Meeting; March 2024; Chicago, IL.
14. Kasting ML, *Laily A*, Burney H, Head KJ, Daggy J, Zimet GD, Schwab Reese LM. Exploring structural determinants of COVID-19 and influenza vaccination in Indiana. Poster presented at: American Public Health Association 151st Annual Meeting & Expo; November 2023; Atlanta, GA.
15. *Laily A*, Nair I, Shank S, Khamis G, Kelly C, Dykstra C, DeMaria AL, Kasting ML. Improving Uterine Fibroid Care: Addressing Disparities and Exploring Approaches through Healthcare Provider Perspectives. Poster presented at: Women's Global Health Institute Symposium; September 2023; West Lafayette, IN.
16. DeMaria AL, Kasting ML, Hughes-Wegner AT, *Laily A*, Shank S, Khamis G. Improving overall quality of life for uterine fibroid patients living in the USA. Oral presentation at: The 15th Congress of the European Society of Gynecology (ESG); December 2023; Amsterdam, Netherlands.
17. *Laily A*, Duncan R, Gabhart KM, Nephew LD, Christy SM, Vadaparampil ST, Giuliano AR, Kasting ML. Differences in Provider Hepatitis C Virus Screening Recommendations by Patient Risk Status. Poster presented at: Purdue Health and Human Sciences Research Symposium; November 2023; West Lafayette, IN.
18. *Laily A*, Duncan R, Gabhart KM, Nephew LD, Christy SM, Vadaparampil ST, Giuliano AR, Kasting ML. Differences in Provider Hepatitis C Virus Screening Recommendations by Patient Risk Status. Poster presented at: Society of Behavioral Medicine 44th Annual Meeting; April 2023; Phoenix, AZ.
19. *Laily A*, Reed JB, Powers MQ, Giuliano AR, Kasting ML. The Association between Inflammatory Diet and Infection-Related Cancers in Adults: A Systematic Review. Poster presented at: American Academy of Health Behavior 2023 Scientific Meeting; March 2023; San Francisco, CA.
20. Nuranna L, Fatahan N, Puspitasari HD, *Laily AN*, Winarto H, Utami TW. Efficacy of Cryotherapy for Cervical Precancer Lesion Treatment in Jatinegara Primary Health Care, 2016. Poster presented at: International Conference and Exhibition on IMERI II; December 2017; Jakarta, Indonesia.
21. *Laily AN*, Nuranna L, Purwoto G, Fatahan N. Population-Based Pre-Cancer Registry of Cervical Cancer in Indonesia: Urgency and Challenge. Poster presented at: International Conference and Exhibition on IMERI II; December 2017; Jakarta, Indonesia.
22. *Laily AN*. The Comparison Effects of Contento's Theory-based Nutrition Education in Calorie Intake Reduction. Oral presentation at: Thesis Dissemination [Gizi Untuk Bangsa]; 2017; Depok, Indonesia.
23. *Laily AN*, Karima AN, Agnur BFP. The Discrepancy of Two International Growth References In Defining Nutritional Status of Children from Suburban Population. Oral presentation at: ISERD International Conference; August 2016; Istanbul, Turkey.
24. Azzahra Q, *Laily AN*, Mutmainnah A. Bread Dregs Coconut: Utilization of Coconut Dregs as Prevention of Coronary Heart Disease. Oral presentation at: International Conference on Medical and Health Sciences-ICMHS; January 2016; Seoul, South Korea.
25. Mutmainnah A, *Laily AN*, Azzahra Q. Increasing Children's Fruit and Vegetable Consumption through Home and School Based Intervention: A Literature Review. Oral presentation at: International Conference on Education and E-Learning Health Sciences; January 2016; Seoul, South Korea.
26. *Laily AN*, Mutmainnah A, Azzahra Q. Nutritional Status of Indonesian Children from Urban Community: Comparison of Two International Growth References. Oral presentation at: International Conference on Medical and Health Sciences-ICMHS; January 2016; Seoul, South Korea.
27. Dzakiyyah IB, Azzahra Q, *Laily AN*. Kersen and Cincau Jelly as Alternative Food for Patients with Diabetes Mellitus. Poster presented at: Asian Congress of Nutrition; May 2015; Yokohama, Japan.
28. Wedya KB, *Laily AN*, Imansari A, Purnamasari DR, Mufidah N, Nurhasanah, Fathimah VR. The Correlation Between Drinking Coffee in the Night-time and Studying Concentration. Oral presentation at: Research Dissemination Nutrition Family Association Universitas Indonesia; 2015; Depok, Indonesia.

  == PATENT RIGHTS
1. Laila N, Purwoto G, Andrijono, Putra AD, Kusuma F, Purbadi S, *Laily AN*. 5 Pillars Concept to Reduce Cervical Cancer in Developing Country [English-Translated]. Indonesian Patent No: C00201704196. 2017. Indonesian Ministry of Law and Human Rights.
2. *Laily AN*. Nutrition Education Model to Decrease Overweight Prevalence in Adults [English-Translated]. Indonesian Patent No: C00201704202. 2017. Indonesian Ministry of Law and Human Rights.
3. Fikawati S, *Laily AN*, Mayasari P, Setyawati A, Harytio ER. Nutrition and Health Report [English-Translated]. Indonesian Patent No: 082968. 2017. Indonesian Ministry of Law and Human Rights.

  == BOOKS & BOOK CHAPTERS
1. Nuranna L, Purwoto G, Anggraeni TD, Fatahan N, Fujiasti YM, *Laily AN*. VIA and Cryotherapy as Alternative Solutions to Prevent Cervical Cancers in Indonesia: Implementation and Challenge [English-Translated]. Jakarta, Indonesia: Universitas Indonesia Press; 2019.
2. Irmawati M, Taqiyyah S, Fu'ad T, *Laily AN*. Complete Guideline of Student Scientific-Creativity Program [English-Translated]. Depok, Indonesia: Universitas Indonesia Press; 2017.
3. Thaha AR, Takdir AK, Djatmiko A, Adhayati B, Ekayanti F, Hadiwijaya, Paranadipa M, Mubarika M, Khumaidi MA, Akbar M, Junari P, Martosuwignjo P, Khuriyati SF, *Laily AN*. White Paper: Objection of Primary-Care Doctor Major, A Scientific Study [English-Translated]. Jakarta, Indonesia: Indonesian Doctor Association; 2017.
4. *Laily AN*, Narayani IA. Blue Paper: Cervical Cancer Center of Excellence [English-Translated]. Jakarta, Indonesia: Female Cancer Program; 2016.
5. Putra WKY, Setiarini A, Utari DM, Mardatillah, *Laily AN*, Azmi M, Putri NMS, Ariyanti R, Putra RM. Balanced Nutrition Modul [English-Translated]. Depok, Indonesia: Nutrition Department, Faculty of Public Health; 2015.
]

= SCIENTIFIC JOURNAL AD-HOC REVIEWER
#grid(
  columns: (1fr, 1fr),
  row-gutter: 0.5em,
  [- Preventive Medicine Reports], [- Patient Education and Counseling],
  [- Journal of Organizational Behavior Management], [- Vaccine],
  [- Health Science Reports], [- Journal of Rural Health],
  [- Journal of Women's Health], [- Emergency Health Services Journal],
)

= ORGANIZATIONS AND MENTORSHIPS
#block(breakable: true)[
  #set par(justify: false)
  #columns(2, gutter: 1em)[
    #cv_entry("2025-now", "Soojung Jo Lab", "Mentor of undergraduate, master, and doctoral students", "")
    #cv_entry("2022-now", "Society of Behavioral Medicine", "Professional member", "")
    #cv_entry("2023-2025", "American Public Health Association", "Professional member", "")
    #cv_entry(
      "2024-2025",
      "Indiana Public Health Association",
      "Student Advisory Group Fall 2024 - Spring 2025 cohort",
      "",
    )
    #cv_entry(
      "2021-2025",
      "Prevention Research Collective (Purdue University)",
      "Mentor of undergraduate, master, and doctoral students",
      "",
    )
    #colbreak()
    #cv_entry("2022-2023", "American Academy of Health Behavior", "Student member", "")
    #cv_entry(
      "2021-2023",
      "Interdisciplinary Women's Reproductive Health Collaborative (Purdue University)",
      "Mentor of undergraduate and master students",
      "",
    )
    #cv_entry("2015-2016", "Leprosy Care Community Indonesia", "Steering Committee", "")
    #cv_entry("2015-2016", "Scientific Journal of Indonesian Nutrition Students [Berkala Ilmiah Mahasiswa Gizi Indonesia – BIMGI]", "Secretary", "")
  ]
]

= ENGAGEMENT AND COMMUNITY SERVICE
#gray_cv_entry(
  "2026",
  "Women's Health Special Interest Group",
  "Abstract reviewer",
  [Reviewed scientific abstracts in the women's health topic for the Best Abstract Award. \ _Society of Behavioral Medicine_],
  true,
)
#gray_cv_entry(
  "2026",
  "Postdoc Affairs - Postdoc Mentoring Award",
  "Application reviewer",
  [Reviewed applications from postdoctoral scholars representing their schools for a mentoring award. \ _Office of the Vice Provost for Graduate Students and Postdoctoral Scholars, Purdue University_],
  false,
)
#gray_cv_entry(
  "2021-2025",
  "Asian American and Asian Resource and Cultural Center (AAARCC)",
  "Ad hoc volunteer",
  [Facilitated and supported diverse cultural events to foster an inclusive campus environment. \ _Asian American and Asian Resource and Cultural Center, Purdue University_],
  true,
)
#gray_cv_entry(
  "2024-2025",
  "Asian and Asian American Graduate Student Association (AAAGraSA)",
  "Treasurer",
  [Orchestrated financial management and initiated the development of programs and events for the graduate student community. \ _Purdue University_],
  false,
)
#gray_cv_entry(
  "2023-2024",
  "Office of Interdisciplinary Graduate Programs (OIGP)",
  "Student Ambassador of Interdisciplinary research",
  [Represented Department of Public Health and advocated for interdisciplinary collaboration by coordinating and supporting university-wide research events. \ _Office of Interdisciplinary Graduate Programs, Purdue University_],
  true,
)
#gray_cv_entry(
  "2022-2024",
  "Department of Public Health's Academic Graduate Committee",
  "Student Committee",
  [Provided student-centered perspectives to refine departmental policies and academic guidelines. \ _Department of Public Health, Purdue University_],
  false,
)
#gray_cv_entry(
  "2022-2023",
  "Public Health Student Association",
  "Secretary",
  [Managed administrative operations and coordinated activities to enhance the public health student community. \ _Department of Public Health, Purdue University_],
  true,
)
#gray_cv_entry(
  "2023",
  "Fall Undergraduate Research Conference",
  "Judge of oral presentation",
  [Evaluated student oral presentations, providing critical academic feedback to help refine the communication skills of undergraduate students. \ _Purdue University_],
  false,
)
#gray_cv_entry(
  "2017-2018",
  "Cervical Cancer Screenings",
  "Committee",
  [Organized and executed community-based screening initiatives across churches, correctional facilities, village halls, and public health centers to increase healthcare access. \ _Female Cancer Program_],
  true,
)
#gray_cv_entry(
  "2017",
  "Cakung: Pilot Project Area of Independent Pre-Cervical Cancer Management",
  "Coordinator",
  [Initiated healthcare provider trainings and directed the implementation of a mobile reporting system to establish local independence in cervical cancer management. \ _Female Cancer Program_],
  false,
)
#gray_cv_entry(
  "2016",
  "Smart School Health Center to Monitor Students' Nutrition Status",
  "Team Leader",
  [Developed nutritional monitoring media, conducted mass health consultations, and mentored "little community health workers" to improve elementary student health outcomes. \ _Ministry of Research, Technology and Higher Education_],
  true,
)
#gray_cv_entry(
  "2013-2015",
  "Sedari Village Nutrition and Health Empowerment",
  "Coordinator Assistant",
  [Executed community surveys and trained local health workers to implement sustainable health and nutrition improvements in a secluded rural region. \ _Pertamina Ltd - Faculty of Public Health, Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2015",
  "Nganget International Work-Camp",
  "Steering committee",
  [Managed a two-week international social camp for 25 undergraduate students, leading activities designed to eliminate social stigma surrounding ex-leprosy patients. \ _Leprosy Care Community Indonesia_],
  true,
)
#gray_cv_entry(
  "2015",
  "Healthy Breakfast for Healthy Generation",
  "Facilitator",
  [Facilitated regional events as a national initiative to promote daily nutritional habits and healthy breakfast routines among elementary school students. \ _Indonesian Nutritionist Association (PERSAGI - AIPGI)_],
  false,
)
#gray_cv_entry(
  "2014",
  "Healthy Manggarai Movement",
  "Nutrition/Health Consultant",
  [Delivered personal clinical consultations and managed the distribution of medicines to underserved residents in the Bantar Gebang slum area, Jakarta. \ _Dreamdelion_],
  true,
)
#gray_cv_entry(
  "2014",
  "Pilot Project Research: Rice Fortification to Diminish Anemia",
  "Chief of Enumerator",
  [Led a team in large-scale data collection and questionnaire administration to evaluate the efficacy of national iron-deficiency interventions. \ _Indonesian Ministry of National Development Planning - Taram Ltd_],
  false,
)
#gray_cv_entry(
  "2013",
  "Research Team in the Nutrition Family Association",
  "Researcher",
  [Conducted research on specialized nutrition topics as part of a collaborative faculty-mentored research group. \ _Nutrition Family Association, Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2013",
  "Grand General Assembly, Model United Nations",
  "Fund Raiser",
  [Raised fundraising efforts within the framework of international diplomacy. \ _Universitas Indonesia Model United Nations_],
  false,
)
#gray_cv_entry(
  "2013",
  "Nutrition Charity for Society",
  "Nutrition Consultant",
  [Provided nutritional guidance and specialized consultations to support health equity for marginalized communities. \ _Nutrition Family Association, Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2012",
  "Campus Social Service (Bakti Sosial Kampus)",
  "Field Coordinator",
  [Directed a multi-faceted charity mission in Bekasi, organizing medical distributions, aerobic sessions, and mass health consultations for local residents. \ _Student Executive Board, Universitas Indonesia_],
  false,
)

= TEACHING, INVITED TALKS, AND WORKSHOPS
#gray_cv_entry(
  "2024",
  "Introduction to the Quantitative Methods of Public Health (PUBH 601)",
  "Teaching Assistant",
  [Managed grading responsibilities and conducted office hours to support graduate student learning. \ _Purdue University_],
  true,
)
#gray_cv_entry(
  "2023-2024",
  "Health Behavior and Health Promotion Course (PUBH 320)",
  "Teaching Assistant",
  [Facilitated student learning through direct lecturing and comprehensive grading of course assignments. \ _Purdue University_],
  false,
)
#gray_cv_entry(
  "2021-2023",
  "Human Diseases and Disorders (PUBH 400)",
  "Teaching Assistant",
  [Managed academic grading for undergraduate students. \ _Purdue University_],
  true,
)
#gray_cv_entry(
  "2017",
  "National Training of Trainer on Women's Cancer Early Detection for Health Care Providers",
  "Committee Member",
  [Coordinated training logistics for healthcare professionals focusing on early cancer detection. \ _Ministry of Health of Republic Indonesia/Female Cancer Program_],
  false,
)
#gray_cv_entry(
  "2017",
  "Rubrik Psikologi: Mental of Winners",
  "Guest Star",
  [Invited and featured as a guest speaker on a national television program discussing psychological resilience and success. \ _Republic Indonesia Television (TVRI)_],
  true,
)
#gray_cv_entry(
  "2017",
  "2nd International Conference on Global Health",
  "Speaker",
  [Presented research findings and insights to an international audience of health professionals and academics. \ _Faculty of Medicine, Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2017",
  "PreCare Workshop: Apps for Cervical Cancer Community-Based Early Detection",
  "Speaker",
  [Demonstrated the utility of mobile applications in enhancing community-based cervical cancer screening efforts. \ _Female Cancer Program_],
  true,
)
#gray_cv_entry(
  "2017",
  "Through Research, Students are Community's Problem Solver",
  "Speaker",
  [Invited and delivered a keynote on the role of student-led research in addressing local community challenges. \ _Student Executive Board Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2017",
  "Workshop of Designing Student Scientific-Creativity Program",
  "Speaker",
  [Invited and provided strategic guidance on developing high-quality scientific proposals for university programs. \ _Student Directorate, Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2017",
  "Seminar for Writing a Student Scientific Program Proposal (PKM)",
  "Speaker",
  [Invited and delivered a comprehensive workshop to over 350 students on the mechanics of writing effective social-health program proposals for national competitions. \ _Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2017",
  "Workshop of Proposal Writing for Science Cup",
  "Speaker",
  [Invited to speak and mentor students on technical writing and proposal structure for scientific competitions. \ _Student Executive Board Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2016",
  "National Dissemination: Thesis Results of FKMUI Nutrition Students",
  "Speaker",
  [Shared primary research findings from undergraduate thesis work with a national academic audience. \ _Nutrition Department Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2016",
  "Writing a Proposal of Student Scientific-Creativity Program",
  "Speaker",
  [Invited and conducted a workshop focused on the fundamentals of scientific inquiry and proposal development. \ _KSM Eka Prasetya, Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2014",
  "Nutrition Expo: Scientific Writing Competition",
  "Committee Member",
  [Managed the logistics and coordination of a university-wide scientific writing contest. \ _Nutrition Family Association Universitas Indonesia_],
  false,
)
#gray_cv_entry(
  "2014",
  "National Seminar of Nutrition: Implementation of Balanced Nutrition Pillars for Excellent Human Resource",
  "Committee Member",
  [Assisted in the organization of a national-scale seminar promoting public health nutrition pillars. \ _Nutrition Department, Universitas Indonesia_],
  true,
)
#gray_cv_entry(
  "2013",
  "Ganesharing Medic: A Sharing Session about Becoming Health Students in Indonesia's Prominent University",
  "Speaker",
  [Provided mentorship and shared academic experiences in the university with high school students. \ _Student Association of Institut Teknologi Bandung_],
  false,
)

#block(breakable: false)[
  = TRAINING
  #set par(justify: false)
  #columns(2, gutter: 1em)[
    #gray_cv_entry("2025", "Entry-Level Programming in Python", "College of Engineering, Purdue University", "", true)
    #gray_cv_entry("2023", "ArcGIS Series", "esri", "", false)
    #gray_cv_entry("2017", "Obesity and The Burden of Non-Communicable Disease", "SEAMEO Regional Center for Food & Nutrition Indonesia", "", true)
    #gray_cv_entry("2015", "World Conference on Disaster Risk Reduction (Japan)", "United Nations (UNDP, UNMGCY)", "", false)
    #gray_cv_entry("2015", "Innovating in Healthcare (Online Course)", "Harvard University", "", true)
    #gray_cv_entry("2015", "Introduction to Psychology (Online Course)", "St. Margaret's Episcopal School", "", false)
    #colbreak()
    #gray_cv_entry("2015", "The Ethics of Eating (Online Course)", "Cornell University", "", true)
    #gray_cv_entry("2015", "Nutrition and Health: Macronutrients and Overnutrition (Online Course)", "Wageningen University", "", false)
    #gray_cv_entry("2015", "Evaluating Social Programs (Online Course)", "Massachusetts Institute of Technology", "", true)
    #gray_cv_entry("2015", "How to Write a Literature Review", "CIMSA Universitas Indonesia", "", false)
    #gray_cv_entry("2015", "Workshop on Food Security and Balanced Nutrition", "Universitas Indonesia", "", true)
    #gray_cv_entry("2014", "Nutrition Software Training", "Universitas Indonesia", "", false)
  ]
]
