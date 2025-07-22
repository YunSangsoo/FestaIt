<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<title>행사 - Calendar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:set var="contextPath" value="${pageContext.request.contextPath}"
	scope="application" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${contextPath}/resources/js/event/calendar.js"></script>
<link href="${contextPath}/resources/css/eventboard.css"
	rel="stylesheet">



<style>
/* 공지 작성 버튼 스타일 */
a.btn.lavender-btn {
	background-color: #b481d9;
	color: white;
	border: 1px solid #a069cb;
}

a.btn.lavender-btn:hover {
	background-color: #a069cb;
	border-color: #904ebc;
}

/* 테이블 헤더 스타일 */
thead.lavender-header th {
	background-color: #e6ccff;
	color: #5E2B97;
}

.btn.white-btn {
	background-color: #ffffff;
	color: black;
	border: 1px solid #000000;
}

.btn.white-btn:hover {
	background-color: #ea870e;
	border-color: #ffffff;
	color: #ffffff;
}

.btn.white-btn:active {
	/* -------------------------------------------------------클릭했을 때 색 */
	background-color: #ea870e;
	border-color: #000000;
	color: #000000;
}
</style>
</head>

<body>


	<div id="calendar"
		class="fc fc-media-screen fc-direction-ltr fc-theme-standard">
		<div class="fc-header-toolbar fc-toolbar fc-toolbar-ltr">
			<div class="fc-toolbar-chunk">
				<div class="fc-button-group">
					<button type="button" title="Previous year" aria-pressed="false"
						class="fc-prevYear-button fc-button fc-button-primary">
						<span class="fc-icon fc-icon-chevrons-left" role="img"></span>
					</button>
					<button type="button" title="Previous month" aria-pressed="false"
						class="fc-prev-button fc-button fc-button-primary">
						<span class="fc-icon fc-icon-chevron-left" role="img"></span>
					</button>
					<button type="button" title="Next month" aria-pressed="false"
						class="fc-next-button fc-button fc-button-primary">
						<span class="fc-icon fc-icon-chevron-right" role="img"></span>
					</button>
					<button type="button" title="Next year" aria-pressed="false"
						class="fc-nextYear-button fc-button fc-button-primary">
						<span class="fc-icon fc-icon-chevrons-right" role="img"></span>
					</button>
				</div>
				<button type="button" title="This month" aria-pressed="false"
					class="fc-today-button fc-button fc-button-primary" disabled="">today</button>
			</div>
			<div class="fc-toolbar-chunk">
				<h2 class="fc-toolbar-title" id="fc-dom-1">July 2025</h2>
			</div>
			<div class="fc-toolbar-chunk">
				<div class="fc-button-group">
					<button type="button" title="month view" aria-pressed="true"
						class="fc-dayGridMonth-button fc-button fc-button-primary fc-button-active">month</button>
					<button type="button" title="week view" aria-pressed="false"
						class="fc-dayGridWeek-button fc-button fc-button-primary">week</button>
					<button type="button" title="day view" aria-pressed="false"
						class="fc-dayGridDay-button fc-button fc-button-primary">day</button>
				</div>
			</div>
		</div>
		<div aria-labelledby="fc-dom-1"
			class="fc-view-harness fc-view-harness-active"
			style="height: 841.481px;">
			<div class="fc-dayGridMonth-view fc-view fc-daygrid">
				<table role="grid" class="fc-scrollgrid  fc-scrollgrid-liquid">
					<thead role="rowgroup">
						<tr role="presentation"
							class="fc-scrollgrid-section fc-scrollgrid-section-header ">
							<th role="presentation"><div class="fc-scroller-harness">
									<div class="fc-scroller" style="overflow: hidden;">
										<table role="presentation" class="fc-col-header "
											style="width: 1132px;">
											<colgroup></colgroup>
											<thead role="presentation">
												<tr role="row">
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-sun"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Sunday" class="fc-col-header-cell-cushion">Sun</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-mon"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Monday" class="fc-col-header-cell-cushion">Mon</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-tue"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Tuesday"
																class="fc-col-header-cell-cushion">Tue</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-wed"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Wednesday"
																class="fc-col-header-cell-cushion">Wed</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-thu"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Thursday"
																class="fc-col-header-cell-cushion">Thu</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-fri"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Friday" class="fc-col-header-cell-cushion">Fri</a>
														</div></th>
													<th role="columnheader"
														class="fc-col-header-cell fc-day fc-day-sat"><div
															class="fc-scrollgrid-sync-inner">
															<a aria-label="Saturday"
																class="fc-col-header-cell-cushion">Sat</a>
														</div></th>
												</tr>
											</thead>
										</table>
									</div>
								</div></th>
						</tr>
					</thead>
					<tbody role="rowgroup">
						<tr role="presentation"
							class="fc-scrollgrid-section fc-scrollgrid-section-body  fc-scrollgrid-section-liquid">
							<td role="presentation"><div
									class="fc-scroller-harness fc-scroller-harness-liquid">
									<div class="fc-scroller fc-scroller-liquid-absolute"
										style="overflow: hidden auto;">
										<div class="fc-daygrid-body fc-daygrid-body-balanced "
											style="width: 1132px;">
											<table role="presentation" class="fc-scrollgrid-sync-table"
												style="width: 1132px; height: 808px;">
												<colgroup></colgroup>
												<tbody role="presentation">
													<tr role="row">
														<td aria-labelledby="fc-dom-478" role="gridcell"
															data-date="2025-06-29"
															class="fc-day fc-day-sun fc-day-past fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to June 29, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-478"
																		class="fc-daygrid-day-number">29</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-480" role="gridcell"
															data-date="2025-06-30"
															class="fc-day fc-day-mon fc-day-past fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to June 30, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-480"
																		class="fc-daygrid-day-number">30</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-482" role="gridcell"
															data-date="2025-07-01"
															class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 1, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-482"
																		class="fc-daygrid-day-number">1</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-484" role="gridcell"
															data-date="2025-07-02"
															class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 2, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-484"
																		class="fc-daygrid-day-number">2</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-486" role="gridcell"
															data-date="2025-07-03"
															class="fc-day fc-day-thu fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 3, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-486"
																		class="fc-daygrid-day-number">3</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-488" role="gridcell"
															data-date="2025-07-04"
															class="fc-day fc-day-fri fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 4, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-488"
																		class="fc-daygrid-day-number">4</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-490" role="gridcell"
															data-date="2025-07-05"
															class="fc-day fc-day-sat fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 5, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-490"
																		class="fc-daygrid-day-number">5</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
													<tr role="row">
														<td aria-labelledby="fc-dom-492" role="gridcell"
															data-date="2025-07-06"
															class="fc-day fc-day-sun fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 6, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-492"
																		class="fc-daygrid-day-number">6</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-494" role="gridcell"
															data-date="2025-07-07"
															class="fc-day fc-day-mon fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 7, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-494"
																		class="fc-daygrid-day-number">7</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="top: 0px; left: 0px; right: -161.695px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Long
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 26px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-496" role="gridcell"
															data-date="2025-07-08"
															class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 8, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-496"
																		class="fc-daygrid-day-number">8</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="top: 26px; left: 0px; right: -323.391px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Long
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 52px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-498" role="gridcell"
															data-date="2025-07-09"
															class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 9, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-498"
																		class="fc-daygrid-day-number">9</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 52px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-500" role="gridcell"
															data-date="2025-07-10"
															class="fc-day fc-day-thu fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 10, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-500"
																		class="fc-daygrid-day-number">10</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="top: 0px; left: 0px; right: -324.258px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-start fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Long
																							Event</div>
																					</div>
																				</div>
																			</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Repeating
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Repeating
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Repeating
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Repeating
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 52px;">
																		<a tabindex="0" title="Show 4 more events"
																			aria-expanded="false" aria-controls=""
																			class="fc-daygrid-more-link fc-more-link">+4 more</a>
																	</div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-502" role="gridcell"
															data-date="2025-07-11"
															class="fc-day fc-day-fri fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 11, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-502"
																		class="fc-daygrid-day-number">11</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 26px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-504" role="gridcell"
															data-date="2025-07-12"
															class="fc-day fc-day-sat fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 12, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-504"
																		class="fc-daygrid-day-number">12</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 26px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
													<tr role="row">
														<td aria-labelledby="fc-dom-506" role="gridcell"
															data-date="2025-07-13"
															class="fc-day fc-day-sun fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 13, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-506"
																		class="fc-daygrid-day-number">13</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-event-harness"
																		style="margin-top: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-end fc-event-past fc-daygrid-event fc-daygrid-block-event fc-h-event"><div
																				class="fc-event-main">
																				<div class="fc-event-main-frame">
																					<div class="fc-event-title-container">
																						<div class="fc-event-title fc-sticky">Long
																							Event</div>
																					</div>
																				</div>
																			</div>
																			<div class="fc-event-resizer fc-event-resizer-end"></div></a>
																	</div>
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-508" role="gridcell"
															data-date="2025-07-14"
															class="fc-day fc-day-mon fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 14, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-508"
																		class="fc-daygrid-day-number">14</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-510" role="gridcell"
															data-date="2025-07-15"
															class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 15, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-510"
																		class="fc-daygrid-day-number">15</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-512" role="gridcell"
															data-date="2025-07-16"
															class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 16, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-512"
																		class="fc-daygrid-day-number">16</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-514" role="gridcell"
															data-date="2025-07-17"
															class="fc-day fc-day-thu fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 17, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-514"
																		class="fc-daygrid-day-number">17</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-516" role="gridcell"
															data-date="2025-07-18"
															class="fc-day fc-day-fri fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 18, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-516"
																		class="fc-daygrid-day-number">18</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-518" role="gridcell"
															data-date="2025-07-19"
															class="fc-day fc-day-sat fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 19, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-518"
																		class="fc-daygrid-day-number">19</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
													<tr role="row">
														<td aria-labelledby="fc-dom-520" role="gridcell"
															data-date="2025-07-20"
															class="fc-day fc-day-sun fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 20, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-520"
																		class="fc-daygrid-day-number">20</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-522" role="gridcell"
															data-date="2025-07-21"
															class="fc-day fc-day-mon fc-day-past fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 21, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-522"
																		class="fc-daygrid-day-number">21</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-524" role="gridcell"
															data-date="2025-07-22"
															class="fc-day fc-day-tue fc-day-today fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 22, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-524"
																		class="fc-daygrid-day-number">22</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-event-harness"
																		style="margin-top: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">All Day Event</div></a>
																	</div>
																	<div class="fc-daygrid-event-harness"
																		style="margin-top: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div class="fc-daygrid-event-harness"
																		style="margin-top: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a href="http://google.com/"
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Click for Google</div></a>
																	</div>
																	<div
																		class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																		style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																		<a
																			class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-daygrid-event fc-daygrid-dot-event"><div
																				class="fc-daygrid-event-dot"></div>
																			<div class="fc-event-time">4:04p</div>
																			<div class="fc-event-title">Repeating Event</div></a>
																	</div>
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;">
																		<a tabindex="0" title="Show 5 more events"
																			aria-expanded="false" aria-controls=""
																			class="fc-daygrid-more-link fc-more-link">+5 more</a>
																	</div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-526" role="gridcell"
															data-date="2025-07-23"
															class="fc-day fc-day-wed fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 23, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-526"
																		class="fc-daygrid-day-number">23</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-528" role="gridcell"
															data-date="2025-07-24"
															class="fc-day fc-day-thu fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 24, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-528"
																		class="fc-daygrid-day-number">24</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-530" role="gridcell"
															data-date="2025-07-25"
															class="fc-day fc-day-fri fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 25, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-530"
																		class="fc-daygrid-day-number">25</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-532" role="gridcell"
															data-date="2025-07-26"
															class="fc-day fc-day-sat fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 26, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-532"
																		class="fc-daygrid-day-number">26</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
													<tr role="row">
														<td aria-labelledby="fc-dom-534" role="gridcell"
															data-date="2025-07-27"
															class="fc-day fc-day-sun fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 27, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-534"
																		class="fc-daygrid-day-number">27</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-536" role="gridcell"
															data-date="2025-07-28"
															class="fc-day fc-day-mon fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 28, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-536"
																		class="fc-daygrid-day-number">28</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-538" role="gridcell"
															data-date="2025-07-29"
															class="fc-day fc-day-tue fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 29, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-538"
																		class="fc-daygrid-day-number">29</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-540" role="gridcell"
															data-date="2025-07-30"
															class="fc-day fc-day-wed fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 30, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-540"
																		class="fc-daygrid-day-number">30</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-542" role="gridcell"
															data-date="2025-07-31"
															class="fc-day fc-day-thu fc-day-future fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to July 31, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-542"
																		class="fc-daygrid-day-number">31</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-544" role="gridcell"
															data-date="2025-08-01"
															class="fc-day fc-day-fri fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 1, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-544"
																		class="fc-daygrid-day-number">1</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-546" role="gridcell"
															data-date="2025-08-02"
															class="fc-day fc-day-sat fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 2, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-546"
																		class="fc-daygrid-day-number">2</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
													<tr role="row">
														<td aria-labelledby="fc-dom-548" role="gridcell"
															data-date="2025-08-03"
															class="fc-day fc-day-sun fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 3, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-548"
																		class="fc-daygrid-day-number">3</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-550" role="gridcell"
															data-date="2025-08-04"
															class="fc-day fc-day-mon fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 4, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-550"
																		class="fc-daygrid-day-number">4</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-552" role="gridcell"
															data-date="2025-08-05"
															class="fc-day fc-day-tue fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 5, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-552"
																		class="fc-daygrid-day-number">5</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-554" role="gridcell"
															data-date="2025-08-06"
															class="fc-day fc-day-wed fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 6, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-554"
																		class="fc-daygrid-day-number">6</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-556" role="gridcell"
															data-date="2025-08-07"
															class="fc-day fc-day-thu fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 7, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-556"
																		class="fc-daygrid-day-number">7</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-558" role="gridcell"
															data-date="2025-08-08"
															class="fc-day fc-day-fri fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 8, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-558"
																		class="fc-daygrid-day-number">8</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
														<td aria-labelledby="fc-dom-560" role="gridcell"
															data-date="2025-08-09"
															class="fc-day fc-day-sat fc-day-future fc-day-other fc-daygrid-day"><div
																class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																<div class="fc-daygrid-day-top">
																	<a title="Go to August 9, 2025" data-navlink=""
																		tabindex="0" id="fc-dom-560"
																		class="fc-daygrid-day-number">9</a>
																</div>
																<div class="fc-daygrid-day-events">
																	<div class="fc-daygrid-day-bottom"
																		style="margin-top: 0px;"></div>
																</div>
																<div class="fc-daygrid-day-bg"></div>
															</div></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>


</body>

</html>