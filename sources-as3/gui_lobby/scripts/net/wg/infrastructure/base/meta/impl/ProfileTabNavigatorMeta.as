package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.ProfileMenuInfoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileTabNavigatorMeta extends BaseDAAPIComponent
   {
       
      
      public var onTabChange:Function;
      
      private var _profileMenuInfoVO:ProfileMenuInfoVO;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      public function ProfileTabNavigatorMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._profileMenuInfoVO)
         {
            this._profileMenuInfoVO.dispose();
            this._profileMenuInfoVO = null;
         }
         if(this._vectorCountersVo)
         {
            for each(_loc1_ in this._vectorCountersVo)
            {
               _loc1_.dispose();
            }
            this._vectorCountersVo.splice(0,this._vectorCountersVo.length);
            this._vectorCountersVo = null;
         }
         super.onDispose();
      }
      
      public function onTabChangeS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTabChange,"onTabChange" + Errors.CANT_NULL);
         this.onTabChange(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ProfileMenuInfoVO = this._profileMenuInfoVO;
         this._profileMenuInfoVO = new ProfileMenuInfoVO(param1);
         this.setInitData(this._profileMenuInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBtnTabCounters(param1:Array) : void
      {
         var _loc5_:CountersVo = null;
         var _loc2_:Vector.<CountersVo> = this._vectorCountersVo;
         this._vectorCountersVo = new Vector.<CountersVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorCountersVo[_loc4_] = new CountersVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setBtnTabCounters(this._vectorCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setInitData(param1:ProfileMenuInfoVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBtnTabCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setBtnTabCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
