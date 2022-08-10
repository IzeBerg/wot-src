package net.wg.gui.lobby.quests.components
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.quests.data.QuestSlotsDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SlotsPanel extends UIComponentEx
   {
       
      
      public var noDataTF:TextField = null;
      
      public var slotsGroup:SlotsGroup;
      
      private var _slotsDP:IDataProvider;
      
      public function SlotsPanel()
      {
         super();
         this.noDataTF.visible = false;
         this.slotsGroup.setSize(width,height);
         this.slotsGroup.itemRendererLinkage = Linkages.QUEST_SLOT_RENDERER;
      }
      
      override protected function onDispose() : void
      {
         this.tryClearData();
         this.noDataTF = null;
         this.slotsGroup.dispose();
         this.slotsGroup = null;
         super.onDispose();
      }
      
      public function setData(param1:QuestSlotsDataVO) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         this.tryClearData();
         _loc2_ = param1.hasActiveQuests;
         this.slotsGroup.visible = _loc2_;
         this.noDataTF.visible = !_loc2_;
         if(_loc2_)
         {
            _loc3_ = App.utils.data.vectorToArray(param1.questSlots);
            this._slotsDP = new DataProvider(_loc3_);
            _loc3_.splice(0,_loc3_.length);
            this.slotsGroup.dataProvider = this._slotsDP;
         }
         else
         {
            this.noDataTF.htmlText = param1.noActiveQuestsText;
         }
      }
      
      private function tryClearData() : void
      {
         if(this._slotsDP != null)
         {
            this._slotsDP.cleanUp();
            this._slotsDP = null;
         }
      }
   }
}
