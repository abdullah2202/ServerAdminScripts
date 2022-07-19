import os

path = "X:/Staff/Planning 2022-23/";

years = ["1. EYFS","2. Year 1","3. Year 2","4. Year 3","5. Year 4","6. Year 5","7. Year 6"]
terms = ["Autumn 1","Autumn 2","Spring 1","Spring 2","Summer 1","Summer 2"]
subjects = ["1. Reading","2. Spelling","3. English","4. Maths","5. Collective Worship","6. Afternoon Sessions"]
sessions = ["1. Humanities","2. Science","3. RE & PHSE","4. Independant Learning Tasks","5. PE","6. Art","7. D&T","8. MFL","9. Computing"]
weeks = dict.fromkeys(terms)
weeks["Autumn 1"] = ["05.09.22","12.09.22","19.09.22","26.09.22","03.10.22","10.10.22","17.10.22"]
weeks["Autumn 2"] = ["31.10.22","07.11.22","14.11.22","21.11.22","28.11.22","05.12.22","12.12.22"]
weeks["Spring 1"] = ["03.01.23","09.01.23","16.01.23","23.01.23","30.01.23","06.02.23","13.02.23"]
weeks["Spring 2"] = ["27.02.23","06.03.23","13.03.23","20.03.23","27.03.23"]
weeks["Summer 1"] = ["17.04.23","24.04.23","01.05.23","08.05.23","15.05.23","22.05.23"]
weeks["Summer 2"] = ["05.06.23","12.06.23","19.06.23","26.06.23","03.07.23","10.07.23","17.07.23","24.07.23"]

for year in years:
    year_dir = os.path.join(path,year)
    os.mkdir(year_dir)
    for term in terms:
        term_dir = os.path.join(year_dir,term)
        os.mkdir(term_dir)
        count = 0;
        for week in weeks[term]:
            count += 1
            week_str = "Week " + str(count) + " - " + week
            week_dir = os.path.join(term_dir,week_str)
            os.mkdir(week_dir)
            for subject in subjects:
                subject_dir = os.path.join(week_dir, subject)
                os.mkdir(subject_dir)
                if subject == "6. Afternoon Sessions":
                    for session in sessions:
                        session_dir = os.path.join(subject_dir, session)
                        os.mkdir(session_dir)
