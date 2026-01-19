import { useState } from 'react';
import svgPaths from '@/imports/svg-ilahrr75d7';
import imgRectangle18084 from "figma:asset/0991d0c7b29663856f189002b6852aa6f52b66cc.png";
import imgRectangle18085 from "figma:asset/0a5020ffc55f5006b4ae5e926c7ac492486da8a3.png";

const timelineOptions = [
  { id: 1, label: '1-2 hr' },
  { id: 2, label: '3-5 hr' },
  { id: 3, label: '6-10 hr' },
  { id: 4, label: '1-2 Days' },
  { id: 5, label: '3-5 Days' },
  { id: 6, label: '1-2 Weeks' },
  { id: 7, label: '1 Month' },
  { id: 8, label: '2 Month' },
  { id: 9, label: '3 Month' },
];

interface AttachedFile {
  id: number;
  name: string;
  size: string;
  thumbnail: string;
}

export default function App() {
  const [description, setDescription] = useState(
    "I am seeking a skilled and reliable service provider to handle the assembly of furniture in my shop. \n\nThe ideal candidate will have experience with assembling various types of furniture, including shelving units, display cases, and seating. "
  );
  const [selectedTimeline, setSelectedTimeline] = useState(4); // 1-2 Days
  const [projectCost, setProjectCost] = useState('SAR 1,500');
  const [attachedFiles, setAttachedFiles] = useState<AttachedFile[]>([
    { id: 1, name: 'Attachment file 2024.jpeg', size: '1.2 MB', thumbnail: imgRectangle18084 },
    { id: 2, name: 'Requirement of project.pdf', size: '3.1 MB', thumbnail: imgRectangle18085 },
  ]);

  const maxChars = 500;
  const charsLeft = maxChars - description.length;

  const handleDeleteFile = (id: number) => {
    setAttachedFiles(attachedFiles.filter(file => file.id !== id));
  };

  const handleSubmit = () => {
    console.log('Submitting proposal:', {
      description,
      timeline: timelineOptions.find(t => t.id === selectedTimeline)?.label,
      cost: projectCost,
      files: attachedFiles,
    });
    alert('Proposal submitted successfully!');
  };

  return (
    <div className="bg-[#fafafa] min-h-screen relative overflow-auto flex justify-center">
      <div className="bg-[#fafafa] relative w-[430px] h-[1221px]">
        {/* Status Bar */}
        <div className="absolute h-[54px] left-0 top-0 w-full px-6 flex items-center justify-between">
          <p className="font-['SF_Pro:Semibold',sans-serif] font-[590] text-[17px] text-black">9:41</p>
          <div className="flex items-center gap-2">
            <svg width="17" height="13" fill="none" viewBox="0 0 17.1417 12.3283">
              <path clipRule="evenodd" d={svgPaths.p18b35300} fill="black" fillRule="evenodd" />
            </svg>
            <svg width="19" height="13" fill="none" viewBox="0 0 19.2 12.2264">
              <path clipRule="evenodd" d={svgPaths.p1e09e400} fill="black" fillRule="evenodd" />
            </svg>
            <div className="relative">
              <div className="border border-black border-solid opacity-35 rounded-[4.3px] w-[25px] h-[13px]" />
              <div className="absolute bg-black rounded-[2.5px] w-[21px] h-[9px] top-[2px] left-[2px]" />
              <svg className="absolute right-[-2px] top-[3.5px]" width="2" height="5" viewBox="0 0 1.32804 4.07547">
                <path d={svgPaths.p193f1400} fill="black" opacity="0.4" />
              </svg>
            </div>
          </div>
        </div>

        {/* Header */}
        <div className="absolute top-[72px] left-[24px] right-[24px] flex items-center gap-[46px]">
          <button className="border border-[#e0e0e0] border-solid rounded-[8px] p-[8px]">
            <div className="size-[24px] flex items-center justify-center rotate-180">
              <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
                <path d={svgPaths.p11a25300} stroke="#111111" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
                <path d="M19.0016 12H5.13837" stroke="#111111" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
              </svg>
            </div>
          </button>
          <p className="font-['Inter:Medium',sans-serif] font-medium text-[18px] text-black text-center flex-1">Submit a quote</p>
        </div>

        {/* Description Section */}
        <div className="absolute top-[151px] left-[24px] right-[24px]">
          <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[16px] text-black mb-[8px]">Description</p>
          <div className="relative">
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              className="bg-white border-[#eaeaea] border-[1.5px] border-solid rounded-[8px] w-full h-[226px] p-[24px] font-['Inter:Regular',sans-serif] text-[16px] text-black leading-[22px] resize-none focus:outline-none focus:border-[#82b600]"
              maxLength={maxChars}
            />
            <button className="absolute right-[16px] top-[16px] size-[10px]">
              <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 10.7071 10.7071">
                <line stroke="black" strokeOpacity="0.3" x1="0.353553" x2="10.3536" y1="10.3536" y2="0.353553" />
                <line stroke="black" strokeOpacity="0.3" x1="5.35355" x2="10.3536" y1="10.3536" y2="5.35355" />
              </svg>
            </button>
          </div>
          <p className="font-['SF_Pro_Display:Regular',sans-serif] text-[14px] text-[#7c7c7c] text-right mt-[16px]">
            {charsLeft} characters left
          </p>
        </div>

        {/* Attach File Section */}
        <div className="absolute top-[475px] left-[24px] right-[24px]">
          <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[16px] text-black mb-[18px]">Attach File</p>

          {/* Upload Area */}
          <div className="bg-white border border-[#827373] border-dashed h-[73px] rounded-[8px] flex items-center justify-center relative mb-[30px]">
            <div className="absolute left-[22px] bg-[#82b600] rounded-[9px] size-[30.746px] flex items-center justify-center">
              <svg className="size-[19px]" fill="none" viewBox="0 0 19.2163 17.2953">
                <ellipse cx="14.6402" cy="3.36286" fill="white" rx="3.20272" ry="3.36286" />
                <path d={svgPaths.p2feced80} fill="white" />
              </svg>
            </div>
            <div className="ml-[45px]">
              <p className="font-['Inter:Medium',sans-serif] font-medium text-[14px] text-[#111]">Attach file</p>
              <p className="font-['Inter:Medium',sans-serif] font-medium text-[14px] text-[rgba(128,128,128,0.55)]">
                pdf, png, jpeg and max 10mb
              </p>
            </div>
          </div>

          {/* Attached Files */}
          <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[16px] text-[rgba(128,128,128,0.55)] mb-[15px]">
            Just attached files
          </p>

          <div className="space-y-[16px]">
            {attachedFiles.map((file) => (
              <div key={file.id} className="flex items-center gap-[7px]">
                <div className="flex items-center gap-[12px] flex-1">
                  <img
                    src={file.thumbnail}
                    alt=""
                    className="w-[41px] h-[39px] rounded-[4px] object-cover"
                  />
                  <div className="flex flex-col gap-[5px]">
                    <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[14px] text-[#111]">{file.name}</p>
                    <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[14px] text-[rgba(0,0,0,0.3)]">{file.size}</p>
                  </div>
                </div>
                <button
                  onClick={() => handleDeleteFile(file.id)}
                  className="border border-[rgba(128,128,128,0.55)] border-solid rounded-[8px] px-[17px] py-[6px] font-['SF_Pro_Display:Regular',sans-serif] text-[14px] text-black hover:bg-gray-50"
                >
                  Delete
                </button>
              </div>
            ))}
          </div>
        </div>

        {/* Timeline Section */}
        <div className="absolute top-[759px] left-[24px] right-[24px]">
          <p className="font-['Inter:Medium',sans-serif] font-medium text-[16px] text-black mb-[8px]">
            Estimate timeline task done?*
          </p>
          <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid h-[55px] rounded-[8px] flex items-center px-[16px] mb-[16px]">
            <p className="font-['Inter:Medium',sans-serif] font-medium text-[16px] text-black">
              {timelineOptions.find(t => t.id === selectedTimeline)?.label}
            </p>
          </div>

          <p className="font-['Inter:Medium',sans-serif] font-medium text-[14px] text-[rgba(0,0,0,0.38)] uppercase mb-[12px]">
            Select time
          </p>

          <div className="flex flex-wrap gap-[8px]">
            {timelineOptions.map((option) => (
              <button
                key={option.id}
                onClick={() => setSelectedTimeline(option.id)}
                className={`flex items-center gap-[4px] px-[10px] py-[6px] rounded-[16px] ${selectedTimeline === option.id
                    ? 'bg-white border border-[#82b600] shadow-[0px_4px_4px_0px_rgba(78,165,47,0.18)]'
                    : 'bg-[#e3e3e3]'
                  }`}
              >
                <p className={`font-['Inter:Medium',sans-serif] font-medium text-[14px] ${selectedTimeline === option.id ? 'text-[#82b600]' : 'text-[rgba(0,0,0,0.7)]'
                  }`}>
                  {option.label}
                </p>
                {selectedTimeline === option.id ? (
                  <svg className="size-[14px]" fill="none" viewBox="0 0 14 14">
                    <path d={svgPaths.p3de7e600} stroke="#82B600" strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" />
                  </svg>
                ) : (
                  <svg className="size-[14px]" fill="none" viewBox="0 0 14 14">
                    <path d={svgPaths.p3cabda00} stroke="black" strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" />
                  </svg>
                )}
              </button>
            ))}
          </div>
        </div>

        {/* Project Cost Section */}
        <div className="absolute top-[1022px] left-[24px] right-[24px]">
          <p className="font-['SF_Pro_Display:Medium',sans-serif] text-[16px] text-black mb-[8px]">
            Project cost add your won *
          </p>
          <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid h-[55px] rounded-[8px] flex items-center px-[16px]">
            <input
              type="text"
              value={projectCost}
              onChange={(e) => setProjectCost(e.target.value)}
              className="font-['Inter:Medium',sans-serif] font-medium text-[16px] text-black w-full bg-transparent outline-none"
            />
          </div>
        </div>

        {/* Bottom Section */}
        <div className="absolute bottom-0 left-0 w-full bg-white shadow-[4px_0px_12.4px_0px_rgba(0,0,0,0.08)] h-[110px] flex items-center justify-center">
          <button
            onClick={handleSubmit}
            className="bg-[#02021d] rounded-[56px] px-[140px] py-[20px] font-['Inter:Medium',sans-serif] font-medium text-[18px] text-[#f5f5f5] hover:bg-[#1a1a2e] transition-colors"
          >
            Submit Proposal
          </button>
          <div className="absolute bottom-[8px] left-1/2 -translate-x-1/2 bg-[#02021d] h-[5px] w-[134px] rounded-[100px]" />
        </div>
      </div>
    </div>
  );
}