import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResumeService {
  /// Generates Ankit Rajput's resume as a PDF and shows the print/share/save dialog.
  static Future<void> generateAndDownload() async {
    final pdf = pw.Document();

    final boldStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 9.5,
    );
    final regularStyle = pw.TextStyle(fontSize: 9);
    final italicStyle = pw.TextStyle(fontSize: 8.5, fontStyle: pw.FontStyle.italic);
    
    // Indigo accent theme matching the new design system
    final headerColor = PdfColor.fromHex('#1E1B4B'); // Deep Indigo-Slate
    final accentColor = PdfColor.fromHex('#4F46E5'); // Theme Indigo Accent
    
    final headerStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 22,
      color: headerColor,
    );
    
    final sectionStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 11,
      color: accentColor,
    );
    
    final divider = pw.Divider(
      color: PdfColor.fromHex('#E0E7FF'), // Light Indigo Divider
      thickness: 0.75,
    );

    pw.Widget section(String title, List<pw.Widget> children) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 8),
          pw.Text(title.toUpperCase(), style: sectionStyle),
          divider,
          pw.SizedBox(height: 3),
          ...children,
        ],
      );
    }

    pw.Widget bullet(String text) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2.5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('• ', style: boldStyle),
            pw.Expanded(child: pw.Text(text, style: regularStyle)),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        build: (pw.Context context) => [
          // Header
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text('ANKIT RAJPUT', style: headerStyle),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Full Stack Developer | Data Science Student | Software Developer',
                  style: boldStyle.copyWith(color: PdfColors.grey700, fontSize: 10),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Kanpur, Uttar Pradesh, India  |  +91 9555937872  |  ankitrajankitraj817@gmail.com',
                  style: regularStyle,
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'https://www.linkedin.com/in/ar955593  |  https://github.com/AR955593  |  https://leetcode.com/u/AR955593/',
                  style: regularStyle,
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          ),

          // Professional Summary
          section('Professional Summary', [
            pw.Text(
              'Computer Science and Data Science undergraduate with hands-on experience in Full Stack Development, Machine Learning, and Data Structures Algorithms (DSA). Skilled in building production-ready web and mobile applications using React.js, Flutter, Python, Node.js, and Flask. Experienced in developing AI-powered systems using TensorFlow and OpenCV for computer vision and image processing.',
              style: regularStyle,
            ),
          ]),

          // Education
          section('Education', [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Maharana Pratap Engineering College, Kanpur', style: boldStyle),
                pw.Text('2023–2027', style: boldStyle),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('B.Tech in Computer Science & Engineering (Data Science)', style: regularStyle),
                pw.Text('CGPA: 7.1/10', style: regularStyle),
              ],
            ),
            pw.SizedBox(height: 4),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Jagrati Public School, Talgram, Kannauj', style: boldStyle),
                pw.Text('2021–2022', style: boldStyle),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Intermediate (12th)', style: regularStyle),
                pw.Text('79%', style: regularStyle),
              ],
            ),
            pw.SizedBox(height: 4),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Jagrati Public School, Talgram, Kannauj', style: boldStyle),
                pw.Text('2019–2020', style: boldStyle),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('High School (10th)', style: regularStyle),
                pw.Text('81%', style: regularStyle),
              ],
            ),
          ]),

          // Technical Skills
          section('Technical Skills', [
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: '• Languages: ', style: boldStyle),
                pw.TextSpan(text: 'C, C++, Java, Python, HTML, CSS, Dart, TypeScript', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: '• FrameworksLibraries: ', style: boldStyle),
                pw.TextSpan(text: 'React.js, Node.js, Flutter', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: '• Developer Tools: ', style: boldStyle),
                pw.TextSpan(text: 'Git, GitHub, VS Code, Linux, REST API Development, Firebase', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: '• Databases: ', style: boldStyle),
                pw.TextSpan(text: 'MySQL, Firebase, MongoDB, SQL (CRUD Operations)', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: '• Additional Skills: ', style: boldStyle),
                pw.TextSpan(text: 'Technical Documentation, Machine Learning, Deep Learning, Public Speaking', style: regularStyle),
              ]),
            ),
          ]),

          // Projects
          section('Projects', [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('AgroSetu AI | GitHub', style: boldStyle),
                pw.Text('Personal Project | Jan 2025 – Present', style: boldStyle),
              ],
            ),
            pw.Text('Tech Stack: HTML, CSS, JavaScript, MongoDB, React.js, Express.js, API Integration', style: italicStyle),
            pw.SizedBox(height: 2),
            bullet('Developed an AI-powered smart agriculture platform enabling crop disease detection through plant leaf image scanning, achieving 92% model accuracy. Features soil analysis, weather prediction, fertilizer recommendation, and an e-commerce marketplace.'),
            bullet('Developed over 5 REST API endpoints using Flask and Node.js to handle ML predictions, user authentication, and real-time data processing for 100+ test users.'),
            bullet('Built responsive React.js web dashboard and cross-platform Flutter mobile app, reducing crop monitoring time by 40%.'),
            bullet('Integrated soil analysis, weather prediction, AI fertilizer recommendation engine, real-time crop market price tracking, and an agriculture e-commerce marketplace.'),

            pw.SizedBox(height: 6),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('PharmaGuard AI | GitHub', style: boldStyle),
                pw.Text('Team Project | Mar 2026', style: boldStyle),
              ],
            ),
            pw.Text('Tech Stack: TypeScript, React.js, Node.js, REST API, AI/ML Integration', style: italicStyle),
            pw.SizedBox(height: 2),
            bullet('Developed an AI-powered clinical decision support web application to address adverse drug reactions, which contribute to over 100,000 preventable deaths annually in the United States.'),
            bullet('Built a TypeScript-based full-stack solution integrating AI to assist healthcare professionals in identifying and preventing dangerous drug interactions.'),

            pw.SizedBox(height: 6),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Portfolio Application | GitHub', style: boldStyle),
                pw.Text('Personal Project | Feb 2026', style: boldStyle),
              ],
            ),
            pw.Text('Tech Stack: Flutter, Dart, Responsive Web Design', style: italicStyle),
            pw.SizedBox(height: 2),
            bullet('Developed a cross-platform personal portfolio using Flutter (Dart), showcasing projects, skills, and achievements with a fully responsive UI.'),

            pw.SizedBox(height: 6),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Advanced Calculator | GitHub', style: boldStyle),
                pw.Text('Personal Project | 2025-2026', style: boldStyle),
              ],
            ),
            pw.Text('Tech Stack: Flutter, Dart', style: italicStyle),
            pw.SizedBox(height: 2),
            bullet('Built a feature-rich cross-platform calculator application using Flutter with a clean, user-friendly interface supporting both simple and complex mathematical operations.'),
          ]),

          // Certifications
          section('Certifications', [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bullet('IBM Data Visualization using Python'),
                      bullet('Software Engineer Certificate — HackerRank (2026)'),
                      bullet('JavaScript Intermediate Certification — HackerRank (2025)'),
                      bullet('Full Stack Web Development Workshop Certificate'),
                    ],
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bullet('Python Basic Certification — HackerRank (2025)'),
                      bullet('PW Hackathon — Lucknow'),
                      bullet('Software Engineering Job Simulation - Wealthmart Global'),
                    ],
                  ),
                ),
              ],
            ),
          ]),

          // Achievements
          section('Achievements', [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bullet('Participated in PW Hackathon 2026 — Lucknow'),
                      bullet('Participated in IIT Patna Hackathon'),
                      bullet('Solved over 200 DSA problems on LeetCode and Hacker Rank'),
                    ],
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      bullet('5-Star Gold Badge in SQL — HackerRank'),
                      bullet('5-Star Gold Badge in Python — HackerRank'),
                      bullet('LeetCode 50 Days Badge 2026'),
                    ],
                  ),
                ),
              ],
            ),
          ]),

          // Soft Skills
          section('Soft Skills', [
            bullet('Problem Solving, Analytical Thinking  |  Adaptability'),
            bullet('Team Collaboration, Leadership'),
          ]),

          // Co-Curricular Activities
          section('Co-Curricular Activities', [
            bullet('Actively participated in competitive programming contests on LeetCode and HackerRank, continuously improving problem-solving and algorithmic skills. Open-source contributor on GitHub with multiple public repositories spanning AI, mobile, and web development.'),
            bullet('Participated in technical workshops and seminars.'),
            bullet('Collaborated in team-based hackathons, including PW Hackathon (Lucknow) and IIT Patna Hackathon.'),
          ]),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Ankit_Rajput_Resume.pdf',
    );
  }
}
