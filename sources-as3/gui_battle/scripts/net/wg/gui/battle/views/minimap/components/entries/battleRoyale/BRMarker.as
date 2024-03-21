package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.Bitmap;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.MarkerTopAnimation;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class BRMarker extends BattleUIComponent implements IVehicleMinimapEntry
   {
      
      public static const INVALID_VEHICLE_ACTION_ANIMATION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const TEXTFIELD_OFFSET:int = -5;
       
      
      public var tf:TextField = null;
      
      public var mcTopAnimation:MarkerTopAnimation = null;
      
      private var _iconContainer:Bitmap;
      
      private var _colorSchMgr:IColorSchemeManager;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _userName:String = "";
      
      private var _entryName:String = "";
      
      private var _actionAnimationType:String = "";
      
      public function BRMarker()
      {
         this._iconContainer = new Bitmap();
         this._colorSchMgr = App.colorSchemeMgr;
         this._atlasMgr = App.atlasMgr;
         super();
         addChildAt(this._iconContainer,0);
         this._iconContainer.smoothing = true;
      }
      
      override protected function onDispose() : void
      {
         this._iconContainer = null;
         this._colorSchMgr = null;
         this._atlasMgr = null;
         this.tf = null;
         this.mcTopAnimation.dispose();
         this.mcTopAnimation = null;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_VEHICLE_ACTION_ANIMATION))
         {
            if(this._actionAnimationType != Values.EMPTY_STR)
            {
               this.mcTopAnimation.playAnim(this._actionAnimationType);
            }
            else
            {
               this.mcTopAnimation.gotoAndStop(1);
            }
         }
      }
      
      public function hide() : void
      {
         this._iconContainer.visible = this.tf.visible = false;
      }
      
      public function hideVehicleName() : void
      {
      }
      
      public function highlight() : void
      {
      }
      
      public function setAlive() : void
      {
      }
      
      public function setAnimation(param1:String) : void
      {
         this._actionAnimationType = param1;
         invalidate(INVALID_VEHICLE_ACTION_ANIMATION);
      }
      
      public function setDead(param1:Boolean) : void
      {
      }
      
      public function setFlagBearer(param1:Boolean) : void
      {
      }
      
      public function setGUILabel(param1:String) : void
      {
      }
      
      public function setInAoI(param1:Boolean) : void
      {
         if(!param1)
         {
            this._actionAnimationType = Values.EMPTY_STR;
            invalidate(INVALID_VEHICLE_ACTION_ANIMATION);
         }
      }
      
      public function setTopAnimationScale(param1:Number) : void
      {
         this.mcTopAnimation.scaleX = this.mcTopAnimation.scaleY = param1;
      }
      
      public function setVehicleHealth(param1:int) : void
      {
      }
      
      public function setVehicleInfo(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
      {
         if(param5 != Values.EMPTY_STR)
         {
            this._actionAnimationType = param5;
            invalidate(INVALID_VEHICLE_ACTION_ANIMATION);
         }
      }
      
      public function show(param1:String, param2:String = "", param3:String = "", param4:String = "", param5:String = "") : void
      {
         var _loc7_:StatsUserProps = null;
         this._entryName = param5;
         this._iconContainer.bitmapData = this._atlasMgr.getNewBitmapData(ATLAS_CONSTANTS.BATTLE_ATLAS,param1);
         this._iconContainer.visible = true;
         if(this._entryName != Values.EMPTY_STR)
         {
            this._iconContainer.transform.colorTransform = this._colorSchMgr.getTransform(this.colorSchemeName);
         }
         var _loc6_:Boolean = param2 != Values.EMPTY_STR;
         if(_loc6_ && this._entryName != Values.EMPTY_STR)
         {
            this.tf.textColor = this._colorSchMgr.getRGB(this.colorSchemeName);
         }
         if(_loc6_ && this._userName != param2)
         {
            this._userName = param2;
            _loc7_ = new StatsUserProps(param2,param3,param4,"",0);
            App.utils.commons.formatPlayerName(this.tf,_loc7_);
         }
         this.tf.visible = _loc6_;
         this._iconContainer.x = -this._iconContainer.width >> 1;
         this._iconContainer.y = -this._iconContainer.height >> 1;
         if(this.tf.visible)
         {
            this.tf.x = this._iconContainer.x + this._iconContainer.width + TEXTFIELD_OFFSET;
         }
      }
      
      public function showExtendedInfo(param1:Boolean) : void
      {
      }
      
      public function showVehicleHp(param1:Boolean) : void
      {
      }
      
      public function showVehicleName() : void
      {
      }
      
      public function unhighlight() : void
      {
      }
      
      public function updateSizeIndex(param1:int) : void
      {
      }
      
      public function get vehicleID() : Number
      {
         return 0;
      }
      
      private function get colorSchemeName() : String
      {
         return "vm_" + this._entryName;
      }
   }
}
