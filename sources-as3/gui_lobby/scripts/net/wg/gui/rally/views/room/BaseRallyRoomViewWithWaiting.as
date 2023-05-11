package net.wg.gui.rally.views.room
{
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BaseRallyRoomViewWithWaiting extends BaseRallyRoomView
   {
      
      private static const ANY_FREE_SLOT:int = -1;
       
      
      public var waitingListSection:BaseWaitListSection = null;
      
      private var _dragDropListDelegateCtrlr:IDisposable = null;
      
      public function BaseRallyRoomViewWithWaiting()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waitingListSection.addEventListener(RallyViewsEvent.ASSIGN_FREE_SLOT_REQUEST,this.onRequestToFreeSlotAssign);
      }
      
      override public function as_getCandidatesDP() : Object
      {
         return this.waitingListSection.getCandidatesDP();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RallyInvalidationType.RALLY_DATA) && rallyData)
         {
            this.waitingListSection.rallyData = rallyData;
            this.initializeDragDropSystem();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.waitingListSection)
         {
            this.waitingListSection.removeEventListener(RallyViewsEvent.ASSIGN_FREE_SLOT_REQUEST,this.onRequestToFreeSlotAssign);
            this.waitingListSection.dispose();
            this.waitingListSection = null;
         }
         if(this._dragDropListDelegateCtrlr)
         {
            this._dragDropListDelegateCtrlr.dispose();
            this._dragDropListDelegateCtrlr = null;
         }
         super.onDispose();
      }
      
      private function onRequestToFreeSlotAssign(param1:RallyViewsEvent) : void
      {
         if(rallyData.isCommander)
         {
            assignSlotRequestS(ANY_FREE_SLOT,param1.data);
         }
      }
      
      protected function initializeDragDropSystem() : void
      {
         var _loc1_:Array = null;
         if(this._dragDropListDelegateCtrlr == null && rallyData.isCommander && rallyData.canAssignToSlot)
         {
            _loc1_ = [this.waitingListSection.candidates,teamSection];
            this._dragDropListDelegateCtrlr = getDragDropDeligateController(_loc1_);
         }
         else if(this._dragDropListDelegateCtrlr != null && !rallyData.isCommander)
         {
            this._dragDropListDelegateCtrlr.dispose();
            this._dragDropListDelegateCtrlr = null;
         }
      }
   }
}
