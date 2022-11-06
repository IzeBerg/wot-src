package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BasePostmortemPanelMeta extends BattleDisplayable
   {
       
      
      private var _userVO:UserVO;
      
      public function BasePostmortemPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._userVO)
         {
            this._userVO.dispose();
            this._userVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:Object) : void
      {
         var _loc8_:UserVO = this._userVO;
         this._userVO = new UserVO(param7);
         this.setDeadReasonInfo(param1,param2,param3,param4,param5,param6,this._userVO);
         if(_loc8_)
         {
            _loc8_.dispose();
         }
      }
      
      protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
      {
         var _loc8_:String = "as_setDeadReasonInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc8_);
         throw new AbstractException(_loc8_);
      }
   }
}
