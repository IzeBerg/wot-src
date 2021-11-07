package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.components.MissionConditionRenderer;
   import net.wg.gui.lobby.missions.event.MissionConditionRendererEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionDetailsConditionRendererAbstract extends MissionConditionRenderer
   {
      
      protected static const LIST_BTN_Y_GAP:int = 10;
      
      protected static const LIST_BTN_X_GAP:int = 5;
       
      
      public var listBtn:ISoundButtonEx;
      
      public function MissionDetailsConditionRendererAbstract()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(rendererData != null && isInvalid(InvalidationType.DATA))
         {
            if(rendererData.isCondition)
            {
               mouseChildren = true;
               mouseEnabled = false;
               this.listBtn.visible = true;
               this.listBtn.validateNow();
               this.updateListButtonLayout();
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.listBtn.addEventListener(MouseEvent.CLICK,this.onListBtnClickHandler);
         this.listBtn.addEventListener(MouseEvent.ROLL_OVER,this.onListBtnRollOverHandler);
         this.listBtn.addEventListener(MouseEvent.ROLL_OUT,this.onListBtnRollOutHandler);
         this.listBtn.visible = false;
         this.initListButton();
      }
      
      override protected function onDispose() : void
      {
         this.listBtn.removeEventListener(MouseEvent.CLICK,this.onListBtnClickHandler);
         this.listBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onListBtnRollOverHandler);
         this.listBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onListBtnRollOutHandler);
         this.listBtn.dispose();
         this.listBtn = null;
         super.onDispose();
      }
      
      protected function updateListButtonLayout() : void
      {
         var _loc1_:String = "updateListButtonLayout" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         throw new AbstractException(_loc1_);
      }
      
      protected function initListButton() : void
      {
         var _loc1_:String = "initListButton" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         throw new AbstractException(_loc1_);
      }
      
      private function onListBtnClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new MissionConditionRendererEvent(MissionConditionRendererEvent.CLICK,rendererData.conditionData.data,true));
      }
      
      private function onListBtnRollOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      private function onListBtnRollOverHandler(param1:MouseEvent) : void
      {
         showTooltip();
      }
   }
}
