package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.infrastructure.base.DAAPISimpleContainer;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CrosshairPanelContainerMeta extends DAAPISimpleContainer
   {
       
      
      public var as_playSound:Function;
      
      private var _vectorGunMarkerIndicatorVO:Vector.<GunMarkerIndicatorVO>;
      
      private var _vectorShotFlyTimeVO:Vector.<ShotFlyTimeVO>;
      
      private var _vectorNumber:Vector.<Number>;
      
      public function CrosshairPanelContainerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:GunMarkerIndicatorVO = null;
         var _loc2_:ShotFlyTimeVO = null;
         if(this._vectorGunMarkerIndicatorVO)
         {
            for each(_loc1_ in this._vectorGunMarkerIndicatorVO)
            {
               _loc1_.dispose();
            }
            this._vectorGunMarkerIndicatorVO.splice(0,this._vectorGunMarkerIndicatorVO.length);
            this._vectorGunMarkerIndicatorVO = null;
         }
         if(this._vectorShotFlyTimeVO)
         {
            for each(_loc2_ in this._vectorShotFlyTimeVO)
            {
               _loc2_.dispose();
            }
            this._vectorShotFlyTimeVO.splice(0,this._vectorShotFlyTimeVO.length);
            this._vectorShotFlyTimeVO = null;
         }
         if(this._vectorNumber)
         {
            this._vectorNumber.splice(0,this._vectorNumber.length);
            this._vectorNumber = null;
         }
         super.onDispose();
      }
      
      public function as_playSoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.as_playSound,"as_playSound" + Errors.CANT_NULL);
         this.as_playSound(param1);
      }
      
      public final function as_setGunMarkersIndicators(param1:Array) : void
      {
         var _loc5_:GunMarkerIndicatorVO = null;
         var _loc2_:Vector.<GunMarkerIndicatorVO> = this._vectorGunMarkerIndicatorVO;
         this._vectorGunMarkerIndicatorVO = new Vector.<GunMarkerIndicatorVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorGunMarkerIndicatorVO[_loc4_] = new GunMarkerIndicatorVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setGunMarkersIndicators(this._vectorGunMarkerIndicatorVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setShotFlyTimes(param1:Array) : void
      {
         var _loc5_:ShotFlyTimeVO = null;
         var _loc2_:Vector.<ShotFlyTimeVO> = this._vectorShotFlyTimeVO;
         this._vectorShotFlyTimeVO = new Vector.<ShotFlyTimeVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorShotFlyTimeVO[_loc4_] = new ShotFlyTimeVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setShotFlyTimes(this._vectorShotFlyTimeVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_addOverheat(param1:Array) : void
      {
         var _loc2_:Vector.<Number> = this._vectorNumber;
         this._vectorNumber = new Vector.<Number>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorNumber[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.addOverheat(this._vectorNumber);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setGunMarkersIndicators(param1:Vector.<GunMarkerIndicatorVO>) : void
      {
         var _loc2_:String = "as_setGunMarkersIndicators" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setShotFlyTimes(param1:Vector.<ShotFlyTimeVO>) : void
      {
         var _loc2_:String = "as_setShotFlyTimes" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function addOverheat(param1:Vector.<Number>) : void
      {
         var _loc2_:String = "as_addOverheat" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
