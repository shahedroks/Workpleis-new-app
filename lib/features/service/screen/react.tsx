import svgPaths from "./svg-3oylp3r862";

function BackArrowIcon() {
  return (
    <div className="relative size-[24px]" data-name="Back Arrow Icon">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="Back Arrow Icon">
          <path d={svgPaths.p11a25300} id="Vector" stroke="var(--stroke-0, #111111)" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
          <path d="M19.0016 12H5.13837" id="Vector_2" stroke="var(--stroke-0, #111111)" strokeLinecap="round" strokeLinejoin="round" strokeMiterlimit="10" strokeWidth="1.92001" />
          <g id="Vector_3" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function Arrow() {
  return (
    <div className="absolute content-stretch flex items-start left-[24px] p-[8px] rounded-[8px] top-[72px]" data-name="Arrow">
      <div aria-hidden="true" className="absolute border border-[#e0e0e0] border-solid inset-0 pointer-events-none rounded-[8px]" />
      <div className="flex items-center justify-center relative shrink-0">
        <div className="flex-none scale-y-[-100%]">
          <BackArrowIcon />
        </div>
      </div>
    </div>
  );
}

function HeaderContainer() {
  return (
    <div className="absolute contents left-[24px] top-[72px]" data-name="Header Container">
      <Arrow />
      <p className="absolute css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] left-[calc(50%+0.5px)] not-italic text-[18px] text-black text-center top-[81px] translate-x-[-50%] w-[211px]">Set up withdrawals</p>
    </div>
  );
}

function Time() {
  return (
    <div className="absolute h-[54px] left-0 right-[64.25%] top-1/2 translate-y-[-50%]" data-name="Time">
      <p className="absolute css-ew64yg font-['SF_Pro:Semibold',sans-serif] font-[590] inset-[33.96%_35.41%_25.3%_38.26%] leading-[22px] text-[17px] text-black text-center" style={{ fontVariationSettings: "'wdth' 100" }}>
        9:41
      </p>
    </div>
  );
}

function Battery() {
  return (
    <div className="absolute bottom-[33.33%] contents left-[calc(50%+24.8px)] top-[42.59%] translate-x-[-50%]" data-name="Battery">
      <div className="absolute border border-black border-solid bottom-[33.33%] left-[calc(50%+23.64px)] opacity-35 rounded-[4.3px] top-[42.59%] translate-x-[-50%] w-[25px]" data-name="Border" />
      <div className="absolute bottom-[41.01%] left-[calc(50%+37.8px)] top-[51.45%] translate-x-[-50%] w-[1.328px]" data-name="Cap">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 1.32804 4.07547">
            <path d={svgPaths.p193f1400} fill="var(--fill-0, black)" id="Cap" opacity="0.4" />
          </svg>
        </div>
      </div>
      <div className="absolute bg-black bottom-[37.04%] left-[calc(50%+23.64px)] rounded-[2.5px] top-[46.3%] translate-x-[-50%] w-[21px]" data-name="Capacity" />
    </div>
  );
}

function Levels() {
  return (
    <div className="absolute h-[54px] left-[64.25%] right-0 top-1/2 translate-y-[-50%]" data-name="Levels">
      <Battery />
      <div className="absolute bottom-[33.4%] left-[calc(50%-4.59px)] top-[43.77%] translate-x-[-50%] w-[17.142px]" data-name="Wifi">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 17.1417 12.3283">
            <path clipRule="evenodd" d={svgPaths.p18b35300} fill="var(--fill-0, black)" fillRule="evenodd" id="Wifi" />
          </svg>
        </div>
      </div>
      <div className="absolute bottom-[33.77%] left-[calc(50%-30.26px)] top-[43.58%] translate-x-[-50%] w-[19.2px]" data-name="Cellular Connection">
        <div className="absolute inset-0" style={{ "--fill-0": "rgba(0, 0, 0, 1)" } as React.CSSProperties}>
          <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 19.2 12.2264">
            <path clipRule="evenodd" d={svgPaths.p1e09e400} fill="var(--fill-0, black)" fillRule="evenodd" id="Cellular Connection" />
          </svg>
        </div>
      </div>
    </div>
  );
}

function StatusBarIPhone() {
  return (
    <div className="absolute h-[54px] left-0 top-0 w-[430px]" data-name="Status Bar - iPhone">
      <Time />
      <Levels />
    </div>
  );
}

function ChevronDown() {
  return (
    <div className="relative size-[24px]" data-name="chevron-down">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="chevron-down">
          <path d="M15 6L9 12L15 18" id="Vector" stroke="var(--stroke-0, #002807)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" />
        </g>
      </svg>
    </div>
  );
}

function Group() {
  return (
    <div className="absolute contents left-[24px] top-[170px]">
      <div className="absolute bg-white border-[#eaeaea] border-[1.5px] border-solid h-[56px] left-1/2 rounded-[8px] top-[170px] translate-x-[-50%] w-[382px]" />
      <div className="absolute flex items-center justify-center left-[calc(75%+47.5px)] size-[24px] top-[calc(50%-864.5px)] translate-y-[-50%]" style={{ "--transform-inner-width": "0", "--transform-inner-height": "0" } as React.CSSProperties}>
        <div className="flex-none rotate-[270deg]">
          <ChevronDown />
        </div>
      </div>
      <p className="absolute css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] left-[calc(37.5%-117.25px)] not-italic text-[18px] text-black top-[calc(50%-875.5px)] w-[314px]">Please Select...</p>
    </div>
  );
}

function Group1() {
  return (
    <div className="absolute contents left-[24px] top-[144px]">
      <p className="absolute css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] left-[calc(50%-191px)] not-italic text-[16px] text-black top-[144px] w-[382px]">Select bank *</p>
      <Group />
    </div>
  );
}

function Group3() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">23456788765</p>
    </div>
  );
}

function Group2() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Account number *</p>
      <Group3 />
    </div>
  );
}

function Group5() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">234</p>
    </div>
  );
}

function Group4() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Zip code *</p>
      <Group5 />
    </div>
  );
}

function ChevronDown1() {
  return (
    <div className="relative size-[24px]" data-name="chevron-down">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="chevron-down">
          <path d="M15 6L9 12L15 18" id="Vector" stroke="var(--stroke-0, #002807)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" />
        </g>
      </svg>
    </div>
  );
}

function Group7() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-0 mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <div className="col-1 flex items-center justify-center ml-[346px] mt-[16px] relative row-1 size-[24px]" style={{ "--transform-inner-width": "0", "--transform-inner-height": "3.5" } as React.CSSProperties}>
        <div className="flex-none rotate-[270deg]">
          <ChevronDown1 />
        </div>
      </div>
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[18px] text-black w-[314px]">Please Select...</p>
    </div>
  );
}

function Group6() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Bank account type *</p>
      <Group7 />
    </div>
  );
}

function Group9() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Branch name</p>
    </div>
  );
}

function Group8() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Bank Name*</p>
      <Group9 />
    </div>
  );
}

function Group11() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Branch address</p>
    </div>
  );
}

function Group10() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Bank Address *</p>
      <Group11 />
    </div>
  );
}

function Group13() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">First name</p>
    </div>
  );
}

function Group12() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">First name *</p>
      <Group13 />
    </div>
  );
}

function Group15() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Last name</p>
    </div>
  );
}

function Group14() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Last name *</p>
      <Group15 />
    </div>
  );
}

function Calendar() {
  return (
    <div className="col-1 ml-[16px] mt-[16px] relative row-1 size-[24px]" data-name="calendar-04">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="calendar-04">
          <path d="M16 2V6M8 2V6" id="Vector" stroke="var(--stroke-0, #B5B5B5)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" />
          <path d={svgPaths.p14193bf0} id="Vector_2" stroke="var(--stroke-0, #B5B5B5)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" />
          <path d="M3 10H21" id="Vector_3" stroke="var(--stroke-0, #B5B5B5)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="1.5" />
        </g>
      </svg>
    </div>
  );
}

function Group17() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-0 mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <Calendar />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[48px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Enter date of birth</p>
    </div>
  );
}

function Group16() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Enter date of birth *</p>
      <Group17 />
    </div>
  );
}

function Frame1() {
  return (
    <div className="content-stretch flex flex-col h-[23px] items-start relative shrink-0 w-[362px]">
      <p className="css-4hzbpn font-['SF_Pro_Display:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[14px] text-black w-full">Customer ID type</p>
    </div>
  );
}

function RadioButton() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="Radio button">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="Radio button">
          <circle cx="12" cy="12" id="Ellipse 44" r="11.5" stroke="var(--stroke-0, #82B600)" />
          <circle cx="12" cy="12" fill="var(--fill-0, #82B600)" id="Ellipse 45" r="7" />
        </g>
      </svg>
    </div>
  );
}

function Frame3() {
  return (
    <div className="content-stretch flex gap-[8px] items-center relative shrink-0">
      <RadioButton />
      <div className="css-g0mm18 flex flex-col font-['SF_Pro_Display:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[16px] text-black">
        <p className="css-ew64yg leading-[normal]">{`Driver's license only`}</p>
      </div>
    </div>
  );
}

function Frame4() {
  return (
    <div className="content-stretch flex items-center relative shrink-0 w-[204px]">
      <Frame3 />
    </div>
  );
}

function Frame2() {
  return (
    <div className="content-stretch flex flex-col gap-[9px] items-start relative shrink-0 w-full">
      <Frame1 />
      <Frame4 />
    </div>
  );
}

function Group19() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Enter account name</p>
    </div>
  );
}

function Group18() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Name on account *</p>
      <Group19 />
    </div>
  );
}

function Group21() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Enter account name</p>
    </div>
  );
}

function Group20() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">{`City & Sate/province *`}</p>
      <Group21 />
    </div>
  );
}

function ChevronDown2() {
  return (
    <div className="relative size-[24px]" data-name="chevron-down">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="chevron-down">
          <path d="M15 6L9 12L15 18" id="Vector" stroke="var(--stroke-0, #002807)" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" />
        </g>
      </svg>
    </div>
  );
}

function Group23() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-0 mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <div className="col-1 flex items-center justify-center ml-[346px] mt-[16px] relative row-1 size-[24px]" style={{ "--transform-inner-width": "0", "--transform-inner-height": "3.5" } as React.CSSProperties}>
        <div className="flex-none rotate-[270deg]">
          <ChevronDown2 />
        </div>
      </div>
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[18px] text-black w-[314px]">Please Select...</p>
    </div>
  );
}

function Group22() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Country *</p>
      <Group23 />
    </div>
  );
}

function Group25() {
  return (
    <div className="col-1 grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] ml-[calc(50%-191px)] mt-[26px] relative row-1">
      <div className="bg-white border-[#eaeaea] border-[1.5px] border-solid col-1 h-[56px] ml-0 mt-0 rounded-[8px] row-1 w-[382px]" />
      <p className="col-1 css-4hzbpn font-['Inter:Regular',sans-serif] font-normal leading-[normal] ml-[20px] mt-[17px] not-italic relative row-1 text-[#b5b5b5] text-[18px] w-[314px]">Enter number</p>
    </div>
  );
}

function Group24() {
  return (
    <div className="grid-cols-[max-content] grid-rows-[max-content] inline-grid items-[start] justify-items-[start] leading-[0] relative shrink-0">
      <p className="col-1 css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[normal] ml-0 mt-0 not-italic relative row-1 text-[16px] text-black w-[382px]">Phone Number *</p>
      <Group25 />
    </div>
  );
}

function Frame5() {
  return (
    <div className="absolute content-stretch flex flex-col gap-[24px] items-start left-[24px] top-[493px] w-[382px]">
      <Group2 />
      <Group4 />
      <Group6 />
      <Group8 />
      <Group10 />
      <Group12 />
      <Group14 />
      <Group16 />
      <Frame2 />
      <Group18 />
      <Group20 />
      <Group22 />
      <Group24 />
    </div>
  );
}

function Check() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="Check">
      <div className="absolute bg-white border border-[#9b9b9b] border-solid inset-0 rounded-[6px]" />
    </div>
  );
}

function Frame() {
  return (
    <div className="absolute bottom-[130px] content-stretch flex gap-[12px] items-start left-[24px]">
      <Check />
      <p className="css-4hzbpn font-['Inter:Medium',sans-serif] font-medium leading-[1.5] not-italic relative shrink-0 text-[16px] text-[rgba(0,0,0,0.87)] w-[346px]">I attest that I’m the owner and have full authorization to this bank account.</p>
    </div>
  );
}

function ColorLight() {
  return (
    <div className="h-[34px] relative shrink-0 w-[430px]" data-name="Color=Light">
      <div className="absolute bg-[#02021d] bottom-[8px] h-[5px] left-1/2 rounded-[100px] translate-x-[-50%] w-[134px]" data-name="Home Indicator" />
    </div>
  );
}

function IOsStatusBarHomeIndicator() {
  return (
    <div className="absolute bottom-[7.93px] content-stretch flex flex-col items-start left-0 w-[430px]" data-name="iOS Status Bar & Home Indicator">
      <ColorLight />
    </div>
  );
}

function Button() {
  return (
    <div className="absolute bg-[#02021d] content-stretch flex gap-[10px] items-center justify-center left-[24px] overflow-clip px-[140px] py-[20px] rounded-[56px] top-[2032px] w-[382px]" data-name="Button">
      <p className="css-ew64yg font-['Inter:Medium',sans-serif] font-medium leading-[normal] not-italic relative shrink-0 text-[#f5f5f5] text-[18px]">Submit Proposal</p>
    </div>
  );
}

function Group26() {
  return (
    <div className="absolute bottom-0 contents left-0">
      <div className="absolute bg-white bottom-0 h-[110px] left-0 shadow-[4px_0px_12.4px_0px_rgba(0,0,0,0.08)] w-[430px]" />
      <IOsStatusBarHomeIndicator />
      <Button />
    </div>
  );
}

export default function SetUpWithdrawals() {
  return (
    <div className="bg-[#f6f6f6] relative size-full" data-name="Set up withdrawals">
      <HeaderContainer />
      <StatusBarIPhone />
      <Group1 />
      <Frame5 />
      <Frame />
      <Group26 />
      <p className="absolute css-g0mm18 font-['Inter:Medium',sans-serif] font-medium leading-[normal] left-[24px] not-italic overflow-hidden text-[#b5b5b5] text-[22px] text-ellipsis top-[434px] w-[382px]">Account Holder Bank Information</p>
      <div className="absolute bg-white border-2 border-[#eaeaea] border-solid h-[173px] left-[24px] rounded-[8px] top-[238px] w-[382px]" />
      <div className="absolute css-g0mm18 flex flex-col font-['SF_Pro_Display:Bold',sans-serif] justify-center leading-[0] left-[calc(12.5%-9.75px)] not-italic text-[16px] text-black top-[308.5px] translate-y-[-50%]">
        <p className="css-ew64yg leading-[normal]">AL RAJHI BANK</p>
      </div>
      <div className="absolute css-g0mm18 flex flex-col font-['SF_Pro_Display:Medium',sans-serif] justify-center leading-[0] left-[calc(37.5%-117.25px)] not-italic text-[14px] text-black top-[335.5px] translate-y-[-50%]">
        <p className="css-ew64yg leading-[normal]">8467 KING FAHD ROAD, AL MURUJ DISTRICT</p>
      </div>
      <p className="absolute css-ew64yg font-['SF_Pro_Display:Bold',sans-serif] leading-[normal] left-[calc(25%-64.5px)] not-italic text-[#82b600] text-[14px] top-[367px]">Not your bank or branch?</p>
      <p className="absolute css-ew64yg font-['SF_Pro_Display:Regular',sans-serif] leading-[normal] left-[calc(12.5%-9.75px)] not-italic text-[14px] text-[rgba(0,0,0,0.7)] top-[265px]">Your selected bank</p>
    </div>
  );
}