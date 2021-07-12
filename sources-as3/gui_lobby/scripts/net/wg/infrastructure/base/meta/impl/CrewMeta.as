package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.crew.TankmenResponseVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CrewMeta extends BaseDAAPIComponent
   {
       
      
      public var onShowRecruitWindowClick:Function;
      
      public var unloadAllTankman:Function;
      
      public var equipTankman:Function;
      
      public var updateTankmen:Function;
      
      public var openPersonalCase:Function;
      
      public var onCrewDogMoreInfoClick:Function;
      
      public var onCrewDogItemClick:Function;
      
      private var _tankmenResponseVO:TankmenResponseVO;
      
      public function CrewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tankmenResponseVO)
         {
            this._tankmenResponseVO.dispose();
            this._tankmenResponseVO = null;
         }
         super.onDispose();
      }
      
      public function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onShowRecruitWindowClick,"onShowRecruitWindowClick" + Errors.CANT_NULL);
         this.onShowRecruitWindowClick(param1,param2);
      }
      
      public function unloadAllTankmanS() : void
      {
         App.utils.asserter.assertNotNull(this.unloadAllTankman,"unloadAllTankman" + Errors.CANT_NULL);
         this.unloadAllTankman();
      }
      
      public function equipTankmanS(param1:String, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.equipTankman,"equipTankman" + Errors.CANT_NULL);
         this.equipTankman(param1,param2);
      }
      
      public function updateTankmenS() : void
      {
         App.utils.asserter.assertNotNull(this.updateTankmen,"updateTankmen" + Errors.CANT_NULL);
         this.updateTankmen();
      }
      
      public function openPersonalCaseS(param1:String, param2:uint) : void
      {
         App.utils.asserter.assertNotNull(this.openPersonalCase,"openPersonalCase" + Errors.CANT_NULL);
         this.openPersonalCase(param1,param2);
      }
      
      public function onCrewDogMoreInfoClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCrewDogMoreInfoClick,"onCrewDogMoreInfoClick" + Errors.CANT_NULL);
         this.onCrewDogMoreInfoClick();
      }
      
      public function onCrewDogItemClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCrewDogItemClick,"onCrewDogItemClick" + Errors.CANT_NULL);
         this.onCrewDogItemClick();
      }
      
      public final function as_tankmenResponse(param1:Object) : void
      {
         var _loc2_:TankmenResponseVO = this._tankmenResponseVO;
         this._tankmenResponseVO = new TankmenResponseVO(param1);
         this.tankmenResponse(this._tankmenResponseVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function tankmenResponse(param1:TankmenResponseVO) : void
      {
         var _loc2_:String = "as_tankmenResponse" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
