<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_name</fullName>
        <field>Unique_Name__c</field>
        <formula>Name</formula>
        <name>Update name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Unique product name</fullName>
        <actions>
            <name>Update_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNEW() || ISCHANGED(Name) || ISBLANK(Unique_Name__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
