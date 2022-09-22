package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
   import net.wg.gui.rally.controls.SlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
   
   public class SortieTeamSection extends TeamSectionWithDropIndicators
   {
       
      
      public var gunnerIcon0:MovieClip = null;
      
      public var gunnerIcon1:MovieClip = null;
      
      public var gunnerIcon2:MovieClip = null;
      
      public var gunnerIcon3:MovieClip = null;
      
      public var gunnerIcon4:MovieClip = null;
      
      public var gunnerIcon5:MovieClip = null;
      
      public var gunnerIcon6:MovieClip = null;
      
      public var gunnerIcon7:MovieClip = null;
      
      public var gunnerIcon8:MovieClip = null;
      
      public var gunnerIcon9:MovieClip = null;
      
      public var gunnerIcon10:MovieClip = null;
      
      public var gunnerIcon11:MovieClip = null;
      
      public var gunnerIcon12:MovieClip = null;
      
      public var gunnerIcon13:MovieClip = null;
      
      public var gunnerIcon14:MovieClip = null;
      
      public var slot0:SortieSlot = null;
      
      public var slot1:SortieSlot = null;
      
      public var slot2:SortieSlot = null;
      
      public var slot3:SortieSlot = null;
      
      public var slot4:SortieSlot = null;
      
      public var slot5:SortieSlot = null;
      
      public var slot6:SortieSlot = null;
      
      public var slot7:SortieSlot = null;
      
      public var slot8:SortieSlot = null;
      
      public var slot9:SortieSlot = null;
      
      public var slot10:SortieSlot = null;
      
      public var slot11:SortieSlot = null;
      
      public var slot12:SortieSlot = null;
      
      public var slot13:SortieSlot = null;
      
      public var slot14:SortieSlot = null;
      
      public var dropTargetIndicator0:SlotDropIndicator = null;
      
      public var dropTargetIndicator1:SlotDropIndicator = null;
      
      public var dropTargetIndicator2:SlotDropIndicator = null;
      
      public var dropTargetIndicator3:SlotDropIndicator = null;
      
      public var dropTargetIndicator4:SlotDropIndicator = null;
      
      public var dropTargetIndicator5:SlotDropIndicator = null;
      
      public var dropTargetIndicator6:SlotDropIndicator = null;
      
      public var dropTargetIndicator7:SlotDropIndicator = null;
      
      public var dropTargetIndicator8:SlotDropIndicator = null;
      
      public var dropTargetIndicator9:SlotDropIndicator = null;
      
      public var dropTargetIndicator10:SlotDropIndicator = null;
      
      public var dropTargetIndicator11:SlotDropIndicator = null;
      
      public var dropTargetIndicator12:SlotDropIndicator = null;
      
      public var dropTargetIndicator13:SlotDropIndicator = null;
      
      public var dropTargetIndicator14:SlotDropIndicator = null;
      
      public function SortieTeamSection()
      {
         super();
      }
      
      override public function getIndicatorsUI() : Vector.<ISlotDropIndicator>
      {
         return new <ISlotDropIndicator>[this.dropTargetIndicator0,this.dropTargetIndicator1,this.dropTargetIndicator2,this.dropTargetIndicator3,this.dropTargetIndicator4,this.dropTargetIndicator5,this.dropTargetIndicator6,this.dropTargetIndicator7,this.dropTargetIndicator8,this.dropTargetIndicator9,this.dropTargetIndicator10,this.dropTargetIndicator11,this.dropTargetIndicator12,this.dropTargetIndicator13,this.dropTargetIndicator14];
      }
      
      override protected function getCountEnabledRows() : int
      {
         var _loc3_:IRallySimpleSlotRenderer = null;
         var _loc1_:int = 0;
         var _loc2_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.slotData && !_loc3_.slotData.isLocked)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateTeamHeader();
      }
      
      override protected function onDispose() : void
      {
         this.gunnerIcon0 = null;
         this.gunnerIcon1 = null;
         this.gunnerIcon2 = null;
         this.gunnerIcon3 = null;
         this.gunnerIcon4 = null;
         this.gunnerIcon5 = null;
         this.gunnerIcon6 = null;
         this.gunnerIcon7 = null;
         this.gunnerIcon8 = null;
         this.gunnerIcon9 = null;
         this.gunnerIcon10 = null;
         this.gunnerIcon11 = null;
         this.gunnerIcon12 = null;
         this.gunnerIcon13 = null;
         this.gunnerIcon14 = null;
         this.slot0 = null;
         this.slot1 = null;
         this.slot2 = null;
         this.slot3 = null;
         this.slot4 = null;
         this.slot5 = null;
         this.slot6 = null;
         this.slot7 = null;
         this.slot8 = null;
         this.slot9 = null;
         this.slot10 = null;
         this.slot11 = null;
         this.slot12 = null;
         this.slot13 = null;
         this.slot14 = null;
         this.dropTargetIndicator0 = null;
         this.dropTargetIndicator1 = null;
         this.dropTargetIndicator2 = null;
         this.dropTargetIndicator3 = null;
         this.dropTargetIndicator4 = null;
         this.dropTargetIndicator5 = null;
         this.dropTargetIndicator6 = null;
         this.dropTargetIndicator7 = null;
         this.dropTargetIndicator8 = null;
         this.dropTargetIndicator9 = null;
         this.dropTargetIndicator10 = null;
         this.dropTargetIndicator11 = null;
         this.dropTargetIndicator12 = null;
         this.dropTargetIndicator13 = null;
         this.dropTargetIndicator14 = null;
         super.onDispose();
      }
      
      override protected function getMembersStr() : String
      {
         return FORTIFICATIONS.SORTIE_ROOM_MEMBERS;
      }
      
      override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
      {
         var _loc3_:SortieSlot = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
         var _loc2_:Vector.<MovieClip> = new <MovieClip>[this.gunnerIcon0,this.gunnerIcon1,this.gunnerIcon2,this.gunnerIcon3,this.gunnerIcon4,this.gunnerIcon5,this.gunnerIcon6,this.gunnerIcon7,this.gunnerIcon8,this.gunnerIcon9,this.gunnerIcon10,this.gunnerIcon11,this.gunnerIcon12,this.gunnerIcon13,this.gunnerIcon14];
         var _loc4_:int = 0;
         var _loc5_:ISlotRendererHelper = new SortieSlotHelper();
         for each(_loc3_ in _loc1_)
         {
            _loc3_.gunnerIcon = _loc2_[_loc4_];
            _loc3_.index = _loc4_++;
            _loc3_.helper = _loc5_;
         }
         return _loc1_;
      }
      
      protected function updateTeamHeader() : void
      {
      }
   }
}
