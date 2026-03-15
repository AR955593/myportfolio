import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResumeService {
  /// Generates Ankit Rajput's resume as a PDF and shows the print/share dialog.
  static Future<void> generateAndDownload() async {
    final pdf = pw.Document();

    final boldStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 9.5,
    );
    final regularStyle = pw.TextStyle(fontSize: 9);
    final headerStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 22,
      color: PdfColors.deepPurple,
    );
    final sectionStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 11,
      color: PdfColors.deepPurple,
    );
    final divider = pw.Divider(
      color: PdfColors.deepPurple200,
      thickness: 0.5,
    );

    pw.Widget section(String title, List<pw.Widget> children) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 10),
          pw.Text(title.toUpperCase(), style: sectionStyle),
          divider,
          pw.SizedBox(height: 4),
          ...children,
        ],
      );
    }

    pw.Widget bullet(String text) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
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
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) => [
          // Header
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text('ANKIT RAJPUT', style: headerStyle),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Full Stack Developer | Data Science Student | Software Developer',
                  style: boldStyle.copyWith(color: PdfColors.grey700, fontSize: 10),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Kanpur, Uttar Pradesh, India  |  +91-9555937872  |  ankitrajankitraj817@gmail.com',
                  style: regularStyle,
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'LinkedIn: linkedin.com/in/ar955593  |  GitHub: github.com/AR955593  |  LeetCode: leetcode.com/u/AR955593',
                  style: regularStyle,
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          ),

          // Professional Summary
          section('Professional Summary', [
            pw.Text(
              'Computer Science and Data Science undergraduate with hands-on expertise in Full Stack Development, Machine Learning, and Data Structures and Algorithms. Skilled in building production-ready web and mobile applications using React.js, Flutter, Python, Node.js, and Flask. Experienced in developing AI-powered systems using TensorFlow and OpenCV for computer vision and image processing. Solved 120+ DSA problems on LeetCode and HackerRank.',
              style: regularStyle,
            ),
          ]),

          // Technical Skills
          section('Technical Skills', [
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Programming Languages: ', style: boldStyle),
                pw.TextSpan(text: 'Python, Java, C, JavaScript, Dart', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Frontend: ', style: boldStyle),
                pw.TextSpan(text: 'React.js, HTML5, CSS3, Tailwind CSS, Responsive Web Design', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Backend: ', style: boldStyle),
                pw.TextSpan(text: 'Node.js, Flask, REST API Development', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Mobile & AI: ', style: boldStyle),
                pw.TextSpan(text: 'Flutter, TensorFlow, OpenCV, Computer Vision, Deep Learning', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Database: ', style: boldStyle),
                pw.TextSpan(text: 'MySQL, Firebase, SQL, CRUD Operations', style: regularStyle),
              ]),
            ),
            pw.SizedBox(height: 2),
            pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: 'Tools: ', style: boldStyle),
                pw.TextSpan(text: 'Git, GitHub, Linux, VS Code, API Integration', style: regularStyle),
              ]),
            ),
          ]),

          // Work Experience
          section('Work Experience', [
            pw.Text('Full Stack and AI Developer — AgroScan Project', style: boldStyle),
            pw.Text('Personal Project | Kanpur, India | Jan 2024 – Present',
                style: regularStyle.copyWith(color: PdfColors.grey600)),
            pw.SizedBox(height: 3),
            bullet('Engineered AI smart agriculture platform with 92% model accuracy using TensorFlow and OpenCV deep learning.'),
            bullet('Developed 5+ REST API endpoints using Flask and Node.js for ML predictions, auth, and real-time data.'),
            bullet('Built React.js web dashboard and cross-platform Flutter mobile app, reducing crop monitoring time by 40%.'),
            bullet('Integrated soil analysis, weather prediction, AI fertilizer engine, market price tracking, and e-commerce.'),

            pw.SizedBox(height: 6),
            pw.Text('NLP Developer — Resume Job Description Matcher', style: boldStyle),
            pw.Text('Personal Project | Kanpur, India | Aug 2024 – Oct 2024',
                style: regularStyle.copyWith(color: PdfColors.grey600)),
            pw.SizedBox(height: 3),
            bullet('Built NLP-based resume screening tool using Python keyword extraction, improving matching accuracy by 35%.'),

            pw.SizedBox(height: 6),
            pw.Text('Flutter Developer — Weather Forecast Application', style: boldStyle),
            pw.Text('Personal Project | Kanpur, India | Jun 2024 – Jul 2024',
                style: regularStyle.copyWith(color: PdfColors.grey600)),
            pw.SizedBox(height: 3),
            bullet('Developed cross-platform Flutter app with real-time weather APIs — temperature, humidity, wind speed, 7-day forecast.'),
          ]),

          // Education
          section('Education', [
            pw.Text(
              'Bachelor of Technology (B.Tech) — Computer Science Engineering (Data Science)',
              style: boldStyle,
            ),
            pw.Text('Maharana Pratap Engineering College, Kanpur | 2023 – 2027 | CGPA: 7.1',
                style: regularStyle),
            pw.Text('Class XII: 79%  |  Class X: 81%', style: regularStyle),
          ]),

          // Achievements
          section('Achievements', [
            bullet('Solved 120+ DSA problems on LeetCode and HackerRank.'),
            bullet('Earned 5-Star Gold Badge in Python on HackerRank.'),
            bullet('Achieved 5-Star Gold Badge in SQL on HackerRank.'),
            bullet('Participated in PW Hackathon 2024 — built innovative software solutions in a team.'),
          ]),

          // Certifications
          section('Certifications', [
            bullet('Software Engineer Certification — HackerRank (2024)'),
            bullet('JavaScript Intermediate Certification — HackerRank (2024)'),
            bullet('Python Basic Certification — HackerRank (2024)'),
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
