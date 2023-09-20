package net.wg.gui.components.damageIndicator
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.utils.RootSWFAtlasManager;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   
   public class DamageIndicator extends Sprite implements IRootAppMainContent
   {
      
      private static const DEFAULT_HEIGHT:int = 1018;
      
      private static const PADDING_LEFT:Number = 251;
      
      private static const PADDING_TOP:Number = 188;
      
      private static const SMALL_SCREEN_OFFSET:Number = 40;
      
      private static const SMALL_SCREEN_MAX_HEIGHT:Number = 800;
       
      
      public var hit_0:DamageIndicatorItem = null;
      
      public var hit_1:DamageIndicatorItem = null;
      
      public var hit_2:DamageIndicatorItem = null;
      
      public var hit_3:DamageIndicatorItem = null;
      
      public var hit_4:DamageIndicatorItem = null;
      
      private var _items:Vector.<DamageIndicatorItem> = null;
      
      private var _stageHalfWidth:Number = 0;
      
      private var _stageHeight:Number = 0;
      
      private var _stageHalfHeight:Number = 0;
      
      private var _xPos:Number = 0;
      
      private var _yPos:Number = 0;
      
      private var _guiScale:int = 1;
      
      private var _isStandard:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function DamageIndicator()
      {
         super();
         if(!RootSWFAtlasManager.instance.isAtlasInitialized(ATLAS_CONSTANTS.DAMAGE_INDICATOR))
         {
            RootSWFAtlasManager.instance.initAtlas(ATLAS_CONSTANTS.DAMAGE_INDICATOR);
         }
         this._items = new <DamageIndicatorItem>[this.hit_0,this.hit_1,this.hit_2,this.hit_3,this.hit_4];
         this.hit_0.init();
         this.hit_1.init();
         this.hit_2.init();
         this.hit_3.init();
         this.hit_4.init();
      }
      
      public function as_hide(param1:int) : void
      {
         this._items[param1].hide();
      }
      
      public function as_setPosition(param1:Number, param2:Number) : void
      {
         this._xPos = param1;
         this._yPos = param2;
         this.updatePosition();
      }
      
      public function as_setScreenSettings(param1:Number, param2:Number, param3:Number) : void
      {
         this._guiScale = param1;
         this._stageHeight = param3;
         this._stageHalfWidth = param2 >> 1;
         this._stageHalfHeight = param3 >> 1;
         this.updatePosition();
      }
      
      public function as_setYaw(param1:int, param2:Number) : void
      {
         this._items[param1].setYaw(param2);
      }
      
      public function as_setAlpha(param1:int, param2:Number) : void
      {
         this._items[param1].alpha = param2;
      }
      
      public function as_showExtended(param1:int, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:Boolean) : void
      {
         var _loc9_:DamageIndicatorItem = this._items[param1];
         _loc9_.showExtended(param2,param3,param4,param5,param6,param7,param8);
         setChildIndex(_loc9_,numChildren - 1);
      }
      
      public function as_showStandard(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:DamageIndicatorItem = this._items[param1];
         _loc4_.showStandard(param2,param3);
         setChildIndex(_loc4_,numChildren - 1);
      }
      
      public function as_updateSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this._isStandard = param1;
         this.updatePosition();
         this.hit_0.updateSettings(param1,param2,param3,param4);
         this.hit_1.updateSettings(param1,param2,param3,param4);
         this.hit_2.updateSettings(param1,param2,param3,param4);
         this.hit_3.updateSettings(param1,param2,param3,param4);
         this.hit_4.updateSettings(param1,param2,param3,param4);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         this._items.splice(0,this._items.length);
         this._items = null;
         this.hit_0.dispose();
         this.hit_1.dispose();
         this.hit_2.dispose();
         this.hit_3.dispose();
         this.hit_4.dispose();
         this.hit_0 = null;
         this.hit_1 = null;
         this.hit_2 = null;
         this.hit_3 = null;
         this.hit_4 = null;
         RootSWFAtlasManager.instance.dispose();
      }
      
      public function hideAll() : void
      {
         var _loc1_:DamageIndicatorItem = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.hide();
         }
      }
      
      public function showSettingExtended(param1:DamageIndicatorExtendedSetting, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:DamageIndicatorItem = this._items[param1.index];
         _loc4_.updateSettings(false,param3,false,param2);
         var _loc5_:Boolean = param1.type == DamageIndicatorExtendedSetting.ALLY;
         _loc4_.showSettingExtended(param1.getBg(),param1.getCircle(),param1.tankName,param1.tankTypeStr,param1.damageValue,_loc5_);
         this.setupDamageIndicatorItem(_loc4_,param1);
      }
      
      public function showSettingStandard(param1:DamageIndicatorStandardSetting) : void
      {
         var _loc2_:DamageIndicatorItem = this._items[param1.index];
         _loc2_.showSettingStandard(param1.getBg());
         _loc2_.updateSettings(true,true,false,true);
         this.setupDamageIndicatorItem(_loc2_,param1);
      }
      
      private function setupDamageIndicatorItem(param1:DamageIndicatorItem, param2:DamageIndicatorStandardSetting) : void
      {
         param1.setYaw(param2.yaw);
         param1.x = param2.x;
         param1.y = param2.y;
         setChildIndex(param1,numChildren - 1);
         this.updatePosition();
      }
      
      private function updatePosition() : void
      {
         var _loc2_:DamageIndicatorItem = null;
         x = PADDING_LEFT - this._stageHalfWidth + this._xPos;
         y = PADDING_TOP - this._stageHalfHeight + this._yPos;
         var _loc1_:Number = 0;
         if(this._isStandard)
         {
            if(this._guiScale <= 1)
            {
               _loc1_ = DEFAULT_HEIGHT - this._stageHalfHeight >> 1;
            }
            else
            {
               _loc1_ = DEFAULT_HEIGHT - this._stageHalfHeight / this._guiScale >> 1;
            }
         }
         else if(this._stageHeight / this._guiScale < SMALL_SCREEN_MAX_HEIGHT)
         {
            _loc1_ = SMALL_SCREEN_OFFSET;
         }
         for each(_loc2_ in this._items)
         {
            _loc2_.scaleX = _loc2_.scaleY = this._guiScale;
            _loc2_.setYOffset(_loc1_);
         }
      }
      
      public function set rotateInfo(param1:Boolean) : void
      {
         this.hit_0.rotateInfo = param1;
         this.hit_1.rotateInfo = param1;
         this.hit_2.rotateInfo = param1;
         this.hit_3.rotateInfo = param1;
         this.hit_4.rotateInfo = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
