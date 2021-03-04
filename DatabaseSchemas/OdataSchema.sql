CREATE TABLE KNS_Agenda (
	AgendaID int NOT NULL PRIMARY KEY,
	Number int,
	ClassificationID int,
	ClassificationDesc varchar(125),
	LeadingAgendaID int,
	KnessetNum int,
	Name varchar(255),
	SubTypeID int,
	SubTypeDesc varchar(125),
	StatusID int,
	InitiatorPersonID int,
	GovRecommendationID int,
	GovRecommendationDesc varchar(125),
	PresidentDecisionDate datetime2,
	PostopenmentReasonID int,
	PostopenmentReasonDesc varchar(125),
	CommitteeID int,
	RecommendCommitteeID int,
	MinisterPersonID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Bill (
	BillID int NOT NULL PRIMARY KEY,
	KnessetNum int,
	Name varchar(255),
	SubTypeID int,
	SubTypeDesc varchar(125),
	PrivateNumber int,
	CommitteeID int,
	StatusID int,
	Number int,
	PostponementReasonID int,
	PostponementReasonDesc varchar(125),
	PublicationDate datetime2,
	MagazineNumber int,
	PageNumber int,
	IsContinuationBill bit,
	SummaryLaw varchar(8000),
	PublicationSeriesID int,
	PublicationSeriesDesc varchar(125),
	PublicationSeriesFirstCall nvarchar(255),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_BillHistoryInitiator (
	BillHistoryInitiatorID int NOT NULL PRIMARY KEY,
	BillID int,
	PersonID int,
	IsInitiator bit,
	StartDate datetime2,
	EndDate datetime2,
	ReasonID int,
	ReasonDesc varchar(125),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_BillInitiator (
	BillInitiatorID int NOT NULL PRIMARY KEY,
	BillID int,
	PersonID int,
	IsInitiator bit,
	Ordinal int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_BillName (
	BillNameID int NOT NULL PRIMARY KEY,
	BillID int,
	Name varchar(500),
	NameHistoryTypeID int,
	NameHistoryTypeDesc varchar(125),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_BillSplit (
	BillSplitID int NOT NULL PRIMARY KEY,
	MainBillID int,
	SplitBillID int,
	Name varchar(250),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_BillUnion (
	BillUnionID int NOT NULL PRIMARY KEY,
	MainBillID int,
	UnionBillID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_CmtSessionItem (
	CmtSessionItemID int NOT NULL PRIMARY KEY,
	ItemID int,
	CommitteeSessionID int,
	Ordinal int,
	StatusID int,
	Name varchar(255),
	ItemTypeID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_CmtSiteCode (
	CmtSiteCode bigint NOT NULL PRIMARY KEY,
	KnsID int,
	SiteId int,
);

CREATE TABLE KNS_Committee (
	CommitteeID int NOT NULL PRIMARY KEY,
	Name varchar(250),
	CategoryID smallint,
	CategoryDesc varchar(150),
	KnessetNum int,
	CommitteeTypeID int,
	CommitteeTypeDesc varchar(125),
	Email varchar(254),
	StartDate datetime2,
	FinishDate datetime2,
	AdditionalTypeID int,
	AdditionalTypeDesc varchar(125),
	ParentCommitteeID int,
	CommitteeParentName varchar(250),
	IsCurrent bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_CommitteeSession (
	CommitteeSessionID int NOT NULL PRIMARY KEY,
	Number int,
	KnessetNum int,
	TypeID int,
	TypeDesc varchar(125),
	CommitteeID int,
	StatusID int,
	StatusDesc varchar(50),
	Location nvarchar(500),
	SessionUrl nvarchar(500),
	BroadcastUrl nvarchar(500),
	StartDate datetime2,
	FinishDate datetime2,
	Note varchar(500),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentAgenda (
	DocumentAgendaID bigint NOT NULL PRIMARY KEY,
	AgendaID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentBill (
	DocumentBillID bigint NOT NULL PRIMARY KEY,
	BillID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentCommitteeSession (
	DocumentCommitteeSessionID bigint NOT NULL PRIMARY KEY,
	CommitteeSessionID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentIsraelLaw (
	DocumentIsraelLawID bigint NOT NULL PRIMARY KEY,
	IsraelLawID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentLaw (
	DocumentLawID bigint NOT NULL PRIMARY KEY,
	LawID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentPlenumSession (
	DocumentPlenumSessionID bigint NOT NULL PRIMARY KEY,
	PlenumSessionID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_DocumentQuery (
	DocumentQueryID bigint NOT NULL PRIMARY KEY,
	QueryID int,
	GroupTypeID tinyint,
	GroupTypeDesc varchar(100),
	ApplicationID tinyint,
	ApplicationDesc varchar(10),
	FilePath varchar(600),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Faction (
	FactionID int NOT NULL PRIMARY KEY,
	Name varchar(50),
	KnessetNum int,
	StartDate datetime2,
	FinishDate datetime2,
	IsCurrent bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_GovMinistry (
	GovMinistryID int NOT NULL PRIMARY KEY,
	Name varchar(50),
	IsActive bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_IsraelLaw (
	IsraelLawID int NOT NULL PRIMARY KEY,
	KnessetNum int,
	Name varchar(255),
	IsBasicLaw bit,
	IsFavoriteLaw bit,
	PublicationDate datetime2,
	LatestPublicationDate datetime2,
	IsBudgetLaw bit,
	LawValidityID int,
	LawValidityDesc varchar(125),
	ValidityStartDate datetime2,
	ValidityStartDateNotes varchar(500),
	ValidityFinishDate datetime2,
	ValidityFinishDateNotes varchar(500),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_IsraelLawBinding (
	IsraelLawBinding int NOT NULL PRIMARY KEY,
	IsraelLawID int,
	IsraelLawReplacedID int,
	LawID int,
	LawTypeID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_IsraelLawClassificiation (
	LawClassificiationID int NOT NULL PRIMARY KEY,
	IsraelLawID int,
	ClassificiationID int,
	ClassificiationDesc varchar(50),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_IsraelLawMinistry (
	LawMinistryID int NOT NULL PRIMARY KEY,
	IsraelLawID int,
	GovMinistryID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_IsraelLawName (
	IsraelLawNameID int NOT NULL PRIMARY KEY,
	IsraelLawID int,
	LawID int,
	LawTypeID int,
	Name varchar(500),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_ItemType (
	ItemTypeID int NOT NULL PRIMARY KEY,
	[Desc] varchar(125),
	TableName varchar(19),
);

CREATE TABLE KNS_JointCommittee (
	JointCommitteeID bigint NOT NULL PRIMARY KEY,
	CommitteeID int,
	ParticipantCommitteeID int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_KnessetDates (
	KnessetDateID int NOT NULL PRIMARY KEY,
	KnessetNum int,
	Name varchar(50),
	Assembly int,
	Plenum int,
	PlenumStart datetime2,
	PlenumFinish datetime2,
	IsCurrent bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Law (
	LawID int NOT NULL PRIMARY KEY,
	TypeID int,
	TypeDesc varchar(125),
	SubTypeID int,
	SubTypeDesc varchar(125),
	KnessetNum int,
	Name varchar(255),
	PublicationDate datetime2,
	PublicationSeriesID int,
	PublicationSeriesDesc varchar(125),
	MagazineNumber varchar(50),
	PageNumber varchar(50),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_LawBinding (
	LawBindingID int NOT NULL PRIMARY KEY,
	LawID int,
	IsraelLawID int,
	ParentLawID int,
	LawTypeID int,
	LawParentTypeID int,
	BindingType int,
	BindingTypeDesc varchar(125),
	PageNumber varchar(50),
	AmendmentType int,
	AmendmentTypeDesc varchar(125),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_MkSiteCode (
	MKSiteCode bigint NOT NULL PRIMARY KEY,
	KnsID int,
	SiteId int,
);

CREATE TABLE KNS_Person (
	PersonID int NOT NULL PRIMARY KEY,
	LastName varchar(50),
	FirstName varchar(50),
	GenderID int,
	GenderDesc varchar(125),
	Email varchar(100),
	IsCurrent bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_PersonToPosition (
	PersonToPositionID int NOT NULL PRIMARY KEY,
	PersonID int,
	PositionID int,
	KnessetNum int,
	StartDate datetime2,
	FinishDate datetime2,
	GovMinistryID int,
	GovMinistryName varchar(50),
	DutyDesc varchar(250),
	FactionID int,
	FactionName varchar(50),
	GovernmentNum int,
	CommitteeID int,
	CommitteeName varchar(250),
	IsCurrent bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_PlenumSession (
	PlenumSessionID int NOT NULL PRIMARY KEY,
	Number int,
	KnessetNum int,
	Name varchar(255),
	StartDate datetime2,
	FinishDate datetime2,
	IsSpecialMeeting bit,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_PlmSessionItem (
	plmPlenumSessionID int NOT NULL PRIMARY KEY,
	ItemID int,
	PlenumSessionID int,
	ItemTypeID int,
	ItemTypeDesc varchar(125),
	Ordinal bigint,
	Name varchar(255),
	StatusID int,
	IsDiscussion int,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Position (
	PositionID int NOT NULL PRIMARY KEY,
	Description varchar(250),
	GenderID int,
	GenderDesc varchar(125),
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Query (
	QueryID int NOT NULL PRIMARY KEY,
	Number int,
	KnessetNum int,
	Name varchar(255),
	TypeID int,
	TypeDesc varchar(125),
	StatusID int,
	PersonID int,
	GovMinistryID int,
	SubmitDate datetime2,
	ReplyMinisterDate datetime2,
	ReplyDatePlanned datetime2,
	LastUpdatedDate datetime2,
);

CREATE TABLE KNS_Status (
	StatusID int NOT NULL PRIMARY KEY,
	[Desc] varchar(50),
	TypeID int,
	TypeDesc varchar(125),
	OrderTransition int,
	IsActive bit,
	LastUpdatedDate datetime2,
);

ALTER TABLE KNS_Agenda ADD CONSTRAINT KNS_Person_KNS_Agenda_InitiatorPersonID FOREIGN KEY (InitiatorPersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_Agenda ADD CONSTRAINT KNS_Person_KNS_Agenda_MinisterPersonID FOREIGN KEY (MinisterPersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_Agenda ADD CONSTRAINT KNS_Committee_KNS_Agenda_CommitteeID FOREIGN KEY (CommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_Agenda ADD CONSTRAINT KNS_Committee_KNS_Agenda_RecommendCommitteeID FOREIGN KEY (RecommendCommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_DocumentAgenda ADD CONSTRAINT KNS_Agenda_KNS_DocumentAgenda_AgendaID FOREIGN KEY (AgendaID) REFERENCES KNS_Agenda(AgendaID)
ALTER TABLE KNS_Agenda ADD CONSTRAINT KNS_Status_KNS_Agenda_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_BillInitiator ADD CONSTRAINT KNS_Bill_KNS_BillInitiator_BillID FOREIGN KEY (BillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillName ADD CONSTRAINT KNS_Bill_KNS_BillName_BillID FOREIGN KEY (BillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillSplit ADD CONSTRAINT KNS_Bill_KNS_BillSplit_SplitBillID FOREIGN KEY (SplitBillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillSplit ADD CONSTRAINT KNS_Bill_KNS_BillSplit_MainBillID FOREIGN KEY (MainBillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillUnion ADD CONSTRAINT KNS_Bill_KNS_BillUnion_UnionBillID FOREIGN KEY (UnionBillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillUnion ADD CONSTRAINT KNS_Bill_KNS_BillUnion_MainBillID FOREIGN KEY (MainBillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_BillHistoryInitiator ADD CONSTRAINT KNS_Bill_KNS_BillHistoryInitiator_BillID FOREIGN KEY (BillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_DocumentBill ADD CONSTRAINT KNS_Bill_KNS_DocumentBill_BillID FOREIGN KEY (BillID) REFERENCES KNS_Bill(BillID)
ALTER TABLE KNS_Bill ADD CONSTRAINT KNS_Bill_KNS_Committee_CommitteeID FOREIGN KEY (CommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_Bill ADD CONSTRAINT KNS_Status_KNS_Bill_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_BillHistoryInitiator ADD CONSTRAINT KNS_Person_KNS_BillHistoryInitiator_PersonID FOREIGN KEY (PersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_BillInitiator ADD CONSTRAINT KNS_Person_KNS_BillInitiator_PersonID FOREIGN KEY (PersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_CmtSessionItem ADD CONSTRAINT KNS_CommitteeSession_KNS_CmtSessionItem_CommitteeSessionID FOREIGN KEY (CommitteeSessionID) REFERENCES KNS_CommitteeSession(CommitteeSessionID)
ALTER TABLE KNS_CmtSessionItem ADD CONSTRAINT KNS_Status_KNS_CmtSessionItem_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_JointCommittee ADD CONSTRAINT KNS_Committee_KNS_JointCommittee_ParticipantCommitteeID FOREIGN KEY (ParticipantCommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_JointCommittee ADD CONSTRAINT KNS_Committee_KNS_JointCommittee_CommitteeID FOREIGN KEY (CommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_CommitteeSession ADD CONSTRAINT KNS_Committee_KNS_CommitteeSession_CommitteeID FOREIGN KEY (CommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_DocumentCommitteeSession ADD CONSTRAINT KNS_CommitteeSession_KNS_DocumentCommitteeSession_CommitteeSessionID FOREIGN KEY (CommitteeSessionID) REFERENCES KNS_CommitteeSession(CommitteeSessionID)
ALTER TABLE KNS_CommitteeSession ADD CONSTRAINT KNS_Status_KNS_CommitteeSession_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_DocumentIsraelLaw ADD CONSTRAINT KNS_IsraelLaw_KNS_DocumentIsraelLaw_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_DocumentPlenumSession ADD CONSTRAINT KNS_PlenumSession_KNS_DocumentPlenumSession_PlenumSessionID FOREIGN KEY (PlenumSessionID) REFERENCES KNS_PlenumSession(PlenumSessionID)
ALTER TABLE KNS_DocumentQuery ADD CONSTRAINT KNS_Query_KNS_DocumentQuery_QueryID FOREIGN KEY (QueryID) REFERENCES KNS_Query(QueryID)
ALTER TABLE KNS_IsraelLawMinistry ADD CONSTRAINT KNS_GovMinistry_KNS_IsraelLawMinistry_GovMinistryID FOREIGN KEY (GovMinistryID) REFERENCES KNS_GovMinistry(GovMinistryID)
ALTER TABLE KNS_Query ADD CONSTRAINT KNS_GovMinistry_KNS_Query_GovMinistryID FOREIGN KEY (GovMinistryID) REFERENCES KNS_GovMinistry(GovMinistryID)
ALTER TABLE KNS_IsraelLawBinding ADD CONSTRAINT KNS_IsraelLaw_KNS_IsraelLawBinding_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_IsraelLawBinding ADD CONSTRAINT KNS_IsraelLaw_KNS_IsraelLawBinding_IsraelLawReplacedID FOREIGN KEY (IsraelLawReplacedID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_IsraelLawName ADD CONSTRAINT KNS_IsraelLaw_KNS_IsraelLawName_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_LawBinding ADD CONSTRAINT KNS_IsraelLaw_KNS_LawBinding_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_IsraelLawMinistry ADD CONSTRAINT KNS_IsraelLaw_KNS_IsraelLawMinistry_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_IsraelLawClassificiation ADD CONSTRAINT KNS_IsraelLaw_KNS_IsraelLawClassificiation_IsraelLawID FOREIGN KEY (IsraelLawID) REFERENCES KNS_IsraelLaw(IsraelLawID)
ALTER TABLE KNS_IsraelLawBinding ADD CONSTRAINT KNS_ItemType_KNS_IsraelLawBinding_LawTypeID FOREIGN KEY (LawTypeID) REFERENCES KNS_ItemType(ItemTypeID)
ALTER TABLE KNS_IsraelLawName ADD CONSTRAINT KNS_ItemType_KNS_IsraelLawName_LawTypeID FOREIGN KEY (LawTypeID) REFERENCES KNS_ItemType(ItemTypeID)
ALTER TABLE KNS_LawBinding ADD CONSTRAINT KNS_ItemType_KNS_LawBinding_LawTypeID FOREIGN KEY (LawTypeID) REFERENCES KNS_ItemType(ItemTypeID)
ALTER TABLE KNS_LawBinding ADD CONSTRAINT KNS_ItemType_KNS_LawBinding_LawParentTypeID FOREIGN KEY (LawParentTypeID) REFERENCES KNS_ItemType(ItemTypeID)
ALTER TABLE KNS_PersonToPosition ADD CONSTRAINT KNS_Person_KNS_PersonToPosition_PersonID FOREIGN KEY (PersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_Query ADD CONSTRAINT KNS_Person_KNS_Query_PersonID FOREIGN KEY (PersonID) REFERENCES KNS_Person(PersonID)
ALTER TABLE KNS_Query ADD CONSTRAINT KNS_Status_KNS_Query_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_PlmSessionItem ADD CONSTRAINT KNS_PlenumSession_KNS_PlmSessionItem_PlenumSessionID FOREIGN KEY (PlenumSessionID) REFERENCES KNS_PlenumSession(PlenumSessionID)
ALTER TABLE KNS_PlmSessionItem ADD CONSTRAINT KNS_ItemType_KNS_PlmSessionItem_ItemTypeID FOREIGN KEY (ItemTypeID) REFERENCES KNS_ItemType(ItemTypeID)
ALTER TABLE KNS_PersonToPosition ADD CONSTRAINT KNS_Position_KNS_PersonToPosition_PositionID FOREIGN KEY (PositionID) REFERENCES KNS_Position(PositionID)
ALTER TABLE KNS_PlmSessionItem ADD CONSTRAINT KNS_Status_KNS_PlmSessionItem_StatusID FOREIGN KEY (StatusID) REFERENCES KNS_Status(StatusID)
ALTER TABLE KNS_PersonToPosition ADD CONSTRAINT KNS_GovMinistry_KNS_PersonToPosition_GovMinistryID FOREIGN KEY (GovMinistryID) REFERENCES KNS_GovMinistry(GovMinistryID)
ALTER TABLE KNS_PersonToPosition ADD CONSTRAINT KNS_Faction_KNS_PersonToPosition_FactionID FOREIGN KEY (FactionID) REFERENCES KNS_Faction(FactionID)
ALTER TABLE KNS_DocumentLaw ADD CONSTRAINT KNS_Law_KNS_DocumentLaw_LawID FOREIGN KEY (LawID) REFERENCES KNS_Law(LawID)
ALTER TABLE KNS_PersonToPosition ADD CONSTRAINT KNS_Committee_KNS_PersonToPosition_CommitteeID FOREIGN KEY (CommitteeID) REFERENCES KNS_Committee(CommitteeID)
ALTER TABLE KNS_CmtSessionItem ADD CONSTRAINT KNS_ItemType_KNS_CmtSessionItem_ItemTypeID FOREIGN KEY (ItemTypeID) REFERENCES KNS_ItemType(ItemTypeID)