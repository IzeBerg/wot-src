package net.wg.gui.components.crosshairPanel.components.artyShot
{
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ArtyShotIndicatorsPanel extends Sprite implements IDisposable
   {
      
      private static const MIN_ITEM_WIDTH:uint = 45;
      
      private static const X_GAP:uint = 7;
       
      
      private var _renderers:Vector.<ArtyShotIndicator>;
      
      private var _dummyGunMarkersData:Vector.<GunMarkerIndicatorVO> = null;
      
      private var _dummyShotFlyTimeData:Vector.<ShotFlyTimeVO> = null;
      
      private var _baseDisposed:Boolean = false;
      
      public function ArtyShotIndicatorsPanel()
      {
         this._renderers = new Vector.<ArtyShotIndicator>();
         super();
      }
      
      protected function onDispose() : void
      {
         var _loc1_:ArtyShotIndicator = null;
         var _loc2_:GunMarkerIndicatorVO = null;
         var _loc3_:ShotFlyTimeVO = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.dispose();
         }
         this._renderers.length = 0;
         this._renderers = null;
         if(this._dummyGunMarkersData)
         {
            for each(_loc2_ in this._dummyGunMarkersData)
            {
               _loc2_.dispose();
            }
            this._dummyGunMarkersData.length = 0;
            this._dummyGunMarkersData = null;
         }
         if(this._dummyShotFlyTimeData)
         {
            for each(_loc3_ in this._dummyGunMarkersData)
            {
               _loc3_.dispose();
            }
            this._dummyShotFlyTimeData.length = 0;
            this._dummyShotFlyTimeData = null;
         }
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setDummyData(param1:Boolean = false) : void
      {
         this._dummyGunMarkersData = new <GunMarkerIndicatorVO>[new GunMarkerIndicatorVO({
            "shellIntCD":20234,
            "shellTypeName":ITEM_TYPES.SHELL_KINDSABBREVIATION_HIGH_EXPLOSIVE,
            "shotResult":0,
            "state":0
         }),new GunMarkerIndicatorVO({
            "shellIntCD":20490,
            "shellTypeName":ITEM_TYPES.SHELL_KINDSABBREVIATION_HIGH_EXPLOSIVE,
            "shotResult":1,
            "state":1
         }),new GunMarkerIndicatorVO({
            "shellIntCD":20746,
            "shellTypeName":ITEM_TYPES.SHELL_KINDSABBREVIATION_ARMOR_PIERCING,
            "shotResult":1,
            "state":0
         })];
         this.setGunMarkersData(this._dummyGunMarkersData,param1);
         this._dummyShotFlyTimeData = new <ShotFlyTimeVO>[new ShotFlyTimeVO({
            "shellIntCD":20234,
            "flyTime":0
         }),new ShotFlyTimeVO({
            "shellIntCD":20490,
            "flyTime":1.3
         }),new ShotFlyTimeVO({
            "shellIntCD":20746,
            "flyTime":0.9
         })];
         this.setShotFlyTimesData(this._dummyShotFlyTimeData);
      }
      
      public function setGunMarkersData(param1:Vector.<GunMarkerIndicatorVO>, param2:Boolean) : void
      {
         var _loc4_:ArtyShotIndicator = null;
         var _loc5_:GunMarkerIndicatorVO = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = param1.length;
         while(this._renderers.length < _loc3_)
         {
            this.addRenderer();
         }
         for each(_loc4_ in this._renderers)
         {
            _loc4_.visible = false;
         }
         _loc5_ = null;
         _loc6_ = MIN_ITEM_WIDTH;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = this._renderers[_loc7_];
            _loc5_ = param1[_loc7_];
            _loc4_.setData(_loc5_,param2);
            _loc6_ = Math.max(_loc4_.minWidth,_loc6_);
            _loc7_++;
         }
         var _loc8_:int = _loc6_ * _loc3_ + X_GAP * (_loc3_ - 1);
         var _loc9_:int = -_loc8_ >> 1;
         _loc10_ = _loc6_ + X_GAP;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = this._renderers[_loc7_];
            _loc4_.x = _loc9_;
            _loc4_.width = _loc6_;
            _loc4_.visible = true;
            _loc9_ += _loc10_;
            _loc7_++;
         }
      }
      
      public function setShotFlyTimesData(param1:Vector.<ShotFlyTimeVO>) : void
      {
         var _loc3_:ShotFlyTimeVO = null;
         var _loc2_:ArtyShotIndicator = null;
         for each(_loc3_ in param1)
         {
            for each(_loc2_ in this._renderers)
            {
               if(_loc2_.data.shellIntCD == _loc3_.shellIntCD)
               {
                  _loc2_.setShotFlyTime(_loc3_);
                  break;
               }
            }
         }
      }
      
      private function addRenderer() : void
      {
         var _loc1_:Class = getDefinitionByName(Linkages.ARTY_SHOT_INDICATOR_RENDERER) as Class;
         var _loc2_:ArtyShotIndicator = new _loc1_();
         addChild(_loc2_);
         this._renderers.push(_loc2_);
      }
   }
}
