package net.wg.gui.prebattle.abstract
{
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
   import net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class PrebattleWindowAbstract extends PrebattleWindowMeta implements IPrebattleWindowMeta
   {
       
      
      public var channelComponent:ChannelComponent;
      
      public function PrebattleWindowAbstract()
      {
         super();
         isSourceTracked = true;
      }
      
      protected static function checkStatus(param1:CoreList, param2:Object) : void
      {
         var _loc3_:PlayerPrbInfoVO = null;
         for each(_loc3_ in param1.dataProvider)
         {
            if(_loc3_.dbID == param2.dbID)
            {
               _loc3_.update(param2);
               param1.invalidateData();
            }
         }
      }
      
      protected static function disposeDataProvider(param1:IDataProvider) : void
      {
         var _loc2_:PlayerPrbInfoVO = null;
         if(param1)
         {
            for each(_loc2_ in param1)
            {
               _loc2_.dispose();
            }
            param1.cleanUp();
         }
      }
      
      public function as_enableLeaveBtn(param1:Boolean) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_enableReadyBtn(param1:Boolean) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_toggleReadyBtn(param1:Boolean) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_setCoolDownForReadyButton(param1:uint) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_refreshPermissions() : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_resetReadyButtonCoolDown() : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.channelComponent.getComponentForFocus());
      }
      
      private function onRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP)
         {
            showFAQWindowS();
            param1.handled = true;
         }
      }
      
      public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void
      {
         throw new AbstractException("This method should be overriden");
      }
   }
}
