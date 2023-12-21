package net.wg.gui.cyberSport.views.unit
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.rally.controls.SlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
   import net.wg.gui.rally.vo.RallySlotVO;
   import net.wg.gui.rally.vo.RallyVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CyberSportTeamSectionBase extends TeamSectionWithDropIndicators
   {
       
      
      public var lblTeamPoints:TextField;
      
      public var slot0:IRallySimpleSlotRenderer;
      
      public var slot1:IRallySimpleSlotRenderer;
      
      public var slot2:IRallySimpleSlotRenderer;
      
      public var slot3:IRallySimpleSlotRenderer;
      
      public var slot4:IRallySimpleSlotRenderer;
      
      public var slot5:IRallySimpleSlotRenderer;
      
      public var slot6:IRallySimpleSlotRenderer;
      
      public var dropTargerIndicator0:SlotDropIndicator;
      
      public var dropTargerIndicator1:SlotDropIndicator;
      
      public var dropTargerIndicator2:SlotDropIndicator;
      
      public var dropTargerIndicator3:SlotDropIndicator;
      
      public var dropTargerIndicator4:SlotDropIndicator;
      
      public var dropTargerIndicator5:SlotDropIndicator;
      
      public var dropTargerIndicator6:SlotDropIndicator;
      
      public function CyberSportTeamSectionBase()
      {
