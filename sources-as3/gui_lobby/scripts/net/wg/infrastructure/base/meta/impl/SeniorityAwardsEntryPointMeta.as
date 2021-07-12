package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPointVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SeniorityAwardsEntryPointMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      public var playSound:Function;
      
      private var _seniorityAwardsEntryPointVO:SeniorityAwardsEntryPointVO;
      
      public function SeniorityAwardsEntryPointMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._seniorityAwardsEntryPointVO)
         {
            this._seniorityAwardsEntryPointVO.dispose();
            this._seniorityAwardsEntryPointVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public function playSoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.playSound,"playSound" + Errors.CANT_NULL);
         this.playSound(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SeniorityAwardsEntryPointVO = this._seniorityAwardsEntryPointVO;
         this._seniorityAwardsEntryPointVO = new SeniorityAwardsEntryPointVO(param1);
         this.setData(this._seniorityAwardsEntryPointVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SeniorityAwardsEntryPointVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
