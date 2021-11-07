package net.wg.gui.prebattle.base
{
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.infrastructure.base.meta.IBasePrebattleRoomViewMeta;
   import net.wg.infrastructure.base.meta.impl.BasePrebattleRoomViewMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BasePrebattleRoomView extends BasePrebattleRoomViewMeta implements IBasePrebattleRoomViewMeta
   {
       
      
      public var channelComponent:ChannelComponent;
      
      public function BasePrebattleRoomView()
      {
         super();
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
      
      public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_setCoolDownForReadyButton(param1:uint) : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_resetReadyButtonCoolDown() : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      public function as_refreshPermissions() : void
      {
         throw new AbstractException("This method should be overriden");
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
