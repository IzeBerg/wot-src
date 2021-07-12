package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestRendererVO extends DAAPIDataClass
   {
       
      
      public var rendererType:int = -1;
      
      public var isSelectable:Boolean = true;
      
      public var bckgrImage:String = "";
      
      public var showBckgrImage:Boolean = false;
      
      public var tooltip:String = "";
      
      public var detailsLinkage:String = "";
      
      public var detailsPyAlias:String = "";
      
      public var isNew:Boolean = false;
      
      public var status:String = "";
      
      public var statusTooltip:String = "";
      
      public var IGR:Boolean = false;
      
      public var taskType:String = "";
      
      public var tasksCount:int = 0;
      
      public var progrBarType:String = "";
      
      public var maxProgrVal:Number = 0;
      
      public var currentProgrVal:Number = 0;
      
      public var questID:String = "";
      
      public var progrTooltip:Object = null;
      
      public var eventType:int = -1;
      
      public var timerDescription:String = "";
      
      public var description:String = "";
      
      public var groupStatus:String = "";
      
      public var isTitle:Boolean = false;
      
      public var isOpen:Boolean = false;
      
      public var groupID:String = "";
      
      public var isAvailable:Boolean = true;
      
      public var newSubtasksCount:int;
      
      public var linkTooltip:String = "";
      
      public function QuestRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:QuestRendererVO = param1 as QuestRendererVO;
         if(!_loc2_)
         {
            return false;
         }
         return this.rendererType == _loc2_.rendererType && this.isSelectable == _loc2_.isSelectable && this.bckgrImage == _loc2_.bckgrImage && this.showBckgrImage == _loc2_.showBckgrImage && this.tooltip == _loc2_.tooltip && this.detailsLinkage == _loc2_.detailsLinkage && this.detailsPyAlias == _loc2_.detailsPyAlias && this.isNew == _loc2_.isNew && this.status == _loc2_.status && this.IGR == _loc2_.IGR && this.taskType == _loc2_.taskType && this.description == _loc2_.description && this.timerDescription == _loc2_.timerDescription && this.tasksCount == _loc2_.tasksCount && this.progrBarType == _loc2_.progrBarType && this.maxProgrVal == _loc2_.maxProgrVal && this.currentProgrVal == _loc2_.currentProgrVal && this.questID == _loc2_.questID && compare(this.progrTooltip,_loc2_.progrTooltip) && this.eventType == _loc2_.eventType && this.isTitle == _loc2_.isTitle && this.isOpen == _loc2_.isOpen && this.newSubtasksCount == _loc2_.newSubtasksCount && this.isAvailable == _loc2_.isAvailable && this.linkTooltip == _loc2_.linkTooltip;
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.progrTooltip);
         this.progrTooltip = null;
         super.onDispose();
      }
   }
}
