const pptxgen = require("pptxgenjs");

const pptx = new pptxgen();
pptx.layout = "LAYOUT_WIDE";
pptx.author = "UW SSEC";
pptx.company = "Scientific Software Engineering Center, University of Washington";
pptx.subject = "CS4Env LLMoxie editable SSEC slide templates";
pptx.title = "CS4Env LLMoxie SSEC Template Deck";
pptx.lang = "en-US";
pptx.theme = {
  headFontFace: "Encode Sans",
  bodyFontFace: "Open Sans",
  lang: "en-US",
};
pptx.defineLayout({ name: "LAYOUT_WIDE", width: 13.333, height: 7.5 });

const C = {
  purple950: "1A0038",
  purple900: "32006E",
  purple700: "4B2E83",
  purple200: "C5B4E3",
  purple100: "E0D7F0",
  purple50: "F0ECF7",
  gold700: "85754D",
  gold500: "B7A57A",
  gold200: "E8E3D3",
  gold100: "F2EFE6",
  gold50: "F9F7F2",
  teal600: "1FB8B0",
  teal500: "2AD2C9",
  teal300: "8FE9E4",
  neutral950: "0D0F10",
  neutral900: "1A1D1F",
  neutral700: "373A3C",
  neutral600: "555A5E",
  neutral300: "C2C6CA",
  neutral200: "D5D8DE",
  neutral100: "ECEEF0",
  neutral50: "F6F7F8",
  white: "FFFFFF",
};

const W = 13.333;
const H = 7.5;
const M = 0.62;
const ST = pptx.ShapeType;

function addSkew(slide, x, y, w, h, color, transparency = 0) {
  slide.addShape(ST.parallelogram, {
    x,
    y,
    w,
    h,
    adjustPoint: 0.28,
    fill: { color, transparency },
    line: { color, transparency: 100 },
  });
}

function addBrandTexture(slide, dark = false) {
  const color = dark ? C.white : C.purple700;
  for (let i = 0; i < 14; i += 1) {
    addSkew(slide, 10.35 + i * 0.18, 6.45 - i * 0.015, 0.05, 1.25, color, dark ? 90 : 92);
  }
}

function addTopBrand(slide, opts = {}) {
  const color = opts.dark ? C.gold500 : C.gold700;
  slide.addText("UW SSEC", {
    x: M,
    y: 0.25,
    w: 1.5,
    h: 0.18,
    margin: 0,
    fontFace: "Encode Sans Compressed",
    fontSize: 10,
    bold: true,
    charSpacing: 1.4,
    color,
  });
}

function addFooter(slide, n, opts = {}) {
  const color = opts.goldFooter ? C.purple950 : opts.dark ? C.purple200 : C.neutral600;
  slide.addText(`Scientific Software Engineering Center - UW`, {
    x: M,
    y: 7.1,
    w: 5.2,
    h: 0.18,
    margin: 0,
    fontFace: "Encode Sans Compressed",
    fontSize: 8.5,
    bold: true,
    charSpacing: 0.7,
    color,
  });
  slide.addText(String(n).padStart(2, "0"), {
    x: 12.25,
    y: 7.1,
    w: 0.45,
    h: 0.18,
    margin: 0,
    align: "right",
    fontFace: "Encode Sans Compressed",
    fontSize: 8.5,
    bold: true,
    color,
  });
}

function lightSlide(n, warm = false) {
  const slide = pptx.addSlide();
  slide.background = { color: warm ? C.gold50 : C.white };
  slide.addShape(ST.rect, {
    x: 0,
    y: 0,
    w: 5,
    h: H,
    fill: { color: warm ? C.gold500 : C.purple700, transparency: warm ? 88 : 94 },
    line: { color: warm ? C.gold500 : C.purple700, transparency: 100 },
  });
  addBrandTexture(slide, false);
  addTopBrand(slide);
  addFooter(slide, n);
  return slide;
}

function dividerSlide(n, title = "Section Title", subtitle = "Optional subtitle or framing line", tag = "CS4ENV LLMOXIE") {
  const slide = pptx.addSlide();
  slide.background = { color: C.purple950 };
  slide.addShape(ST.rect, { x: 0, y: 0, w: W, h: H, fill: { color: C.purple950 }, line: { color: C.purple950 } });
  slide.addShape(ST.rect, { x: 0, y: 0, w: W, h: H, fill: { color: C.purple900, transparency: 18 }, line: { color: C.purple900, transparency: 100 } });
  slide.addShape(ST.arc, { x: 9.0, y: 0.65, w: 3.0, h: 3.0, adjustPoint: 0.5, fill: { color: C.teal500, transparency: 86 }, line: { color: C.teal500, transparency: 100 } });
  for (let i = 0; i < 26; i += 1) addSkew(slide, 9.0 + i * 0.16, 0.1 + i * 0.035, 0.045, 7.1, C.white, 93);
  slide.addShape(ST.rect, { x: 0, y: 6.7, w: W, h: 0.8, fill: { color: C.gold500 }, line: { color: C.gold500 } });
  addSkew(slide, -0.4, 6.42, 14.2, 0.45, C.gold500);
  addTopBrand(slide, { dark: true });
  slide.addText(tag, {
    x: M,
    y: 1.45,
    w: 4.5,
    h: 0.24,
    margin: 0,
    fontFace: "Encode Sans Compressed",
    fontSize: 12,
    bold: true,
    charSpacing: 1.6,
    color: C.teal300,
  });
  slide.addText(title, {
    x: M,
    y: 2.0,
    w: 9.8,
    h: 1.15,
    margin: 0,
    fit: "shrink",
    fontFace: "Encode Sans",
    fontSize: 50,
    bold: true,
    color: C.white,
    breakLine: false,
  });
  addSkew(slide, M, 3.38, 1.1, 0.08, C.teal500);
  slide.addText(subtitle, {
    x: M,
    y: 3.75,
    w: 7.8,
    h: 0.5,
    margin: 0,
    fontFace: "Open Sans",
    fontSize: 19,
    color: C.gold200,
  });
  addFooter(slide, n, { dark: true, goldFooter: true });
  return slide;
}

function title(slide, txt) {
  addSkew(slide, M, 0.76, 0.13, 0.36, C.purple700);
  slide.addText(txt, {
    x: M + 0.28,
    y: 0.67,
    w: 10.6,
    h: 0.48,
    margin: 0,
    fit: "shrink",
    fontFace: "Encode Sans",
    fontSize: 28,
    bold: true,
    color: C.purple700,
  });
  slide.addShape(ST.line, { x: M, y: 1.33, w: 11.9, h: 0, line: { color: C.gold500, width: 1.7 } });
}

function placeholder(slide, x, y, w, h, text, opts = {}) {
  const fill = opts.fill || C.white;
  const border = opts.border || C.neutral200;
  slide.addShape(ST.roundRect, {
    x,
    y,
    w,
    h,
    rectRadius: 0.04,
    fill: { color: fill, transparency: opts.transparency || 0 },
    line: { color: border, width: 1.1, dash: opts.dash ? "dash" : "solid" },
  });
  if (opts.topBar) {
    slide.addShape(ST.rect, { x, y, w, h: 0.07, fill: { color: opts.topBar }, line: { color: opts.topBar } });
  }
  slide.addText(text, {
    x: x + 0.18,
    y: y + h / 2 - 0.16,
    w: Math.max(0.5, w - 0.36),
    h: 0.32,
    margin: 0,
    align: "center",
    valign: "mid",
    fontFace: "Encode Sans Compressed",
    fontSize: opts.fontSize || 12,
    bold: true,
    charSpacing: 0.8,
    color: opts.color || C.neutral600,
    fit: "shrink",
  });
}

function card(slide, x, y, w, h, label, color = C.purple700, fill = C.white) {
  placeholder(slide, x, y, w, h, label, { fill, border: C.neutral200, topBar: color, fontSize: 12 });
}

function badge(slide, x, y, txt, color = C.purple700, textColor = C.white) {
  addSkew(slide, x, y, 1.18, 0.28, color);
  slide.addText(txt, {
    x: x + 0.08,
    y: y + 0.065,
    w: 1.02,
    h: 0.12,
    margin: 0,
    align: "center",
    fontFace: "Encode Sans Compressed",
    fontSize: 7.5,
    bold: true,
    charSpacing: 0.7,
    color: textColor,
    fit: "shrink",
  });
}

function addImageFrame(slide, x, y, w, h, label = "IMAGE / FIGURE PLACEHOLDER") {
  placeholder(slide, x, y, w, h, label, { fill: C.neutral50, border: C.neutral300, dash: true, fontSize: 11 });
  slide.addShape(ST.line, { x: x + 0.25, y: y + 0.25, w: w - 0.5, h: h - 0.5, line: { color: C.neutral300, width: 0.8, transparency: 20 } });
  slide.addShape(ST.line, { x: x + w - 0.25, y: y + 0.25, w: -(w - 0.5), h: h - 0.5, line: { color: C.neutral300, width: 0.8, transparency: 20 } });
}

function addArrow(slide, x1, y1, x2, y2, color = C.gold700) {
  slide.addShape(ST.line, {
    x: x1,
    y: y1,
    w: x2 - x1,
    h: y2 - y1,
    line: { color, width: 1.4, beginArrowType: "none", endArrowType: "triangle" },
  });
}

function makeSlides() {
  dividerSlide(1, "CS4Env LLMoxie", "Editable SSEC-style PowerPoint template deck", "TEMPLATE DECK");

  let s = lightSlide(2);
  title(s, "Three-Column Overview");
  card(s, 0.82, 1.8, 3.55, 3.85, "CARD / TOPIC 1", C.purple700, C.purple50);
  card(s, 4.88, 1.8, 3.55, 3.85, "CARD / TOPIC 2", C.gold500, C.gold50);
  card(s, 8.94, 1.8, 3.55, 3.85, "CARD / TOPIC 3", C.teal500, "EFFCFC");

  dividerSlide(3, "Section Divider", "Use this before a major topic shift", "SECTION");

  s = lightSlide(4);
  title(s, "Two-Column Slide");
  placeholder(s, 0.82, 1.75, 5.25, 4.5, "TEXT / BULLETS", { fill: C.white, topBar: C.purple700 });
  addImageFrame(s, 7.0, 1.75, 5.45, 4.5, "IMAGE PLACEHOLDER");

  s = lightSlide(5, true);
  title(s, "Large Figure + Notes");
  addImageFrame(s, 0.82, 1.65, 7.3, 4.75, "LARGE FIGURE PLACEHOLDER");
  card(s, 8.65, 1.65, 3.8, 1.25, "KEY POINT", C.purple700, C.white);
  card(s, 8.65, 3.05, 3.8, 1.25, "METHOD / CONTEXT", C.gold500, C.white);
  card(s, 8.65, 4.45, 3.8, 1.95, "NOTES / CAVEATS", C.teal500, C.white);

  s = lightSlide(6);
  title(s, "Four-Card Grid");
  [[0.82, 1.72], [6.72, 1.72], [0.82, 4.0], [6.72, 4.0]].forEach(([x, y], i) => {
    const colors = [C.purple700, C.gold500, C.teal500, C.purple700];
    const fills = [C.purple50, C.gold50, "EFFCFC", C.white];
    card(s, x, y, 5.35, 1.72, `CARD ${i + 1}`, colors[i], fills[i]);
  });

  s = lightSlide(7, true);
  title(s, "Quote / Framing Slide");
  s.addShape(ST.rect, { x: 1.05, y: 2.0, w: 0.09, h: 3.0, fill: { color: C.gold500 }, line: { color: C.gold500 } });
  placeholder(s, 1.38, 1.95, 10.2, 2.3, "QUOTE OR PROMPT", { fill: C.gold50, border: C.gold200, fontSize: 16 });
  placeholder(s, 1.38, 4.55, 5.2, 0.65, "ATTRIBUTION", { fill: C.white, border: C.gold200, fontSize: 10 });

  s = lightSlide(8);
  title(s, "Timeline");
  s.addShape(ST.line, { x: 1.2, y: 3.55, w: 10.8, h: 0, line: { color: C.gold500, width: 2.1 } });
  for (let i = 0; i < 5; i += 1) {
    const x = 1.3 + i * 2.55;
    badge(s, x - 0.38, 2.45, `STEP ${i + 1}`, i % 2 ? C.gold700 : C.purple700);
    s.addShape(ST.ellipse, { x: x - 0.1, y: 3.42, w: 0.2, h: 0.2, fill: { color: i % 2 ? C.gold700 : C.purple700 }, line: { color: C.white, width: 1 } });
    placeholder(s, x - 0.76, 4.0, 1.52, 1.1, "MILESTONE", { fill: C.white, border: C.neutral200, fontSize: 9 });
  }

  s = lightSlide(9, true);
  title(s, "Comparison");
  card(s, 0.82, 1.7, 5.45, 4.65, "LEFT OPTION / BEFORE", C.purple700, C.white);
  card(s, 7.0, 1.7, 5.45, 4.65, "RIGHT OPTION / AFTER", C.teal500, C.white);
  badge(s, 5.95, 3.55, "VS", C.gold700);

  s = lightSlide(10);
  title(s, "Table / Matrix");
  const x0 = 0.82, y0 = 1.65, tw = 11.62, rh = 0.7;
  s.addShape(ST.rect, { x: x0, y: y0, w: tw, h: rh, fill: { color: C.purple700 }, line: { color: C.purple700 } });
  ["COLUMN 1", "COLUMN 2", "COLUMN 3", "COLUMN 4"].forEach((t, i) => {
    s.addText(t, { x: x0 + i * (tw / 4) + 0.15, y: y0 + 0.23, w: tw / 4 - 0.3, h: 0.2, margin: 0, fontFace: "Encode Sans Compressed", fontSize: 10, bold: true, color: C.white, charSpacing: 0.8 });
  });
  for (let r = 1; r <= 5; r += 1) {
    s.addShape(ST.rect, { x: x0, y: y0 + r * rh, w: tw, h: rh, fill: { color: r % 2 ? C.white : C.gold50 }, line: { color: C.neutral200, width: 0.7 } });
  }

  s = lightSlide(11);
  title(s, "Process Flow");
  for (let i = 0; i < 4; i += 1) {
    const x = 0.9 + i * 3.05;
    card(s, x, 2.25, 2.3, 2.05, `PROCESS ${i + 1}`, [C.purple700, C.gold500, C.teal500, C.purple700][i], C.white);
    if (i < 3) addArrow(s, x + 2.42, 3.28, x + 2.88, 3.28);
  }
  placeholder(s, 1.6, 5.3, 10.1, 0.65, "OPTIONAL SUMMARY / HANDOFF LINE", { fill: C.purple50, border: C.purple200, fontSize: 10 });

  s = lightSlide(12, true);
  title(s, "Stat Callouts");
  for (let i = 0; i < 3; i += 1) {
    const x = 1.2 + i * 3.85;
    s.addText("##", { x, y: 2.1, w: 2.5, h: 0.85, margin: 0, align: "center", fontFace: "Encode Sans", fontSize: 58, bold: true, color: C.purple700 });
    placeholder(s, x - 0.15, 3.25, 2.8, 1.45, "STAT LABEL", { fill: C.white, border: C.gold200, topBar: [C.purple700, C.gold500, C.teal500][i], fontSize: 11 });
  }

  s = lightSlide(13);
  title(s, "Full-Width Figure");
  addImageFrame(s, 0.82, 1.55, 11.62, 4.95, "FULL-WIDTH SCREENSHOT / DIAGRAM PLACEHOLDER");

  s = pptx.addSlide();
  s.background = { color: C.purple950 };
  addTopBrand(s, { dark: true });
  addFooter(s, 14, { dark: true });
  s.addText("Code / Demo", { x: M, y: 0.82, w: 5.5, h: 0.55, margin: 0, fontFace: "JetBrains Mono", fontSize: 24, color: C.teal500 });
  s.addShape(ST.rect, { x: 0.82, y: 1.75, w: 11.7, h: 4.75, fill: { color: "0D0010" }, line: { color: C.teal500, width: 1.1 } });
  s.addText("// command or code placeholder", { x: 1.15, y: 2.1, w: 10.8, h: 0.3, margin: 0, fontFace: "JetBrains Mono", fontSize: 15, color: C.teal300 });
  s.addText("> output placeholder", { x: 1.15, y: 2.65, w: 10.8, h: 0.3, margin: 0, fontFace: "JetBrains Mono", fontSize: 15, color: C.gold500 });

  s = lightSlide(15, true);
  title(s, "2x2 Content Grid");
  [[0.82, 1.72], [6.72, 1.72], [0.82, 4.0], [6.72, 4.0]].forEach(([x, y], i) => {
    placeholder(s, x, y, 5.35, 1.55, `MODULE ${i + 1}`, { fill: C.white, border: C.gold200, topBar: [C.purple700, C.gold500, C.teal500, C.purple700][i], fontSize: 12 });
  });

  s = lightSlide(16);
  title(s, "Risk / Mitigation Matrix");
  card(s, 0.82, 1.7, 5.45, 2.0, "RISK / PROBLEM", C.purple700, C.purple50);
  card(s, 7.0, 1.7, 5.45, 2.0, "MITIGATION / RESPONSE", C.teal500, "EFFCFC");
  card(s, 0.82, 4.2, 5.45, 1.65, "EVIDENCE", C.gold500, C.gold50);
  card(s, 7.0, 4.2, 5.45, 1.65, "NEXT ACTION", C.purple700, C.white);

  s = lightSlide(17);
  title(s, "Layered Stack");
  const layers = [
    [2.0, 4.85, 9.3, 0.62, C.purple700, "FOUNDATION LAYER"],
    [2.45, 4.05, 8.4, 0.62, C.gold700, "MIDDLE LAYER"],
    [2.9, 3.25, 7.5, 0.62, C.teal600, "APPLICATION LAYER"],
    [3.35, 2.45, 6.6, 0.62, C.purple900, "OUTCOME / TAKEAWAY"],
  ];
  layers.forEach(([x, y, w, h, color, text]) => {
    addSkew(s, x, y, w, h, color);
    s.addText(text, { x: x + 0.25, y: y + 0.19, w: w - 0.5, h: 0.18, margin: 0, align: "center", fontFace: "Encode Sans Compressed", fontSize: 10, bold: true, charSpacing: 0.8, color: C.white });
  });

  s = lightSlide(18, true);
  title(s, "Diagram Canvas");
  addImageFrame(s, 0.82, 1.55, 11.62, 4.95, "DIAGRAM CANVAS");
  for (let i = 0; i < 4; i += 1) {
    const x = [1.7, 4.5, 7.3, 10.1][i];
    s.addShape(ST.ellipse, { x, y: 3.25, w: 0.95, h: 0.95, fill: { color: [C.purple700, C.gold700, C.teal600, C.purple900][i] }, line: { color: C.white, width: 1.2 } });
    s.addText(`N${i + 1}`, { x, y: 3.58, w: 0.95, h: 0.16, margin: 0, align: "center", fontFace: "Encode Sans", fontSize: 10, bold: true, color: C.white });
    if (i < 3) addArrow(s, x + 1.05, 3.73, x + 2.65, 3.73, C.neutral600);
  }

  s = lightSlide(19);
  title(s, "Takeaways");
  for (let i = 0; i < 5; i += 1) {
    const y = 1.65 + i * 0.9;
    s.addShape(ST.ellipse, { x: 0.92, y, w: 0.35, h: 0.35, fill: { color: i % 2 ? C.gold700 : C.purple700 }, line: { color: C.white, width: 1 } });
    placeholder(s, 1.45, y - 0.08, 10.75, 0.52, `TAKEAWAY ${i + 1}`, { fill: i % 2 ? C.gold50 : C.white, border: C.neutral200, fontSize: 10 });
  }

  dividerSlide(20, "Closing Slide", "Questions, next steps, or contact details", "THANK YOU");
}

makeSlides();

pptx.writeFile({ fileName: "cs4env-llmoxie-ssec-blank-template.pptx" });
