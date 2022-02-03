package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class BRMarker extends Sprite implements IDisposable, IVehicleMinimapEntry
   {
      
      private static const TEXTFIELD_OFFSET:int = -5;
       
      
      public var tf:TextField = null;
      
      private var _iconContainer:Bitmap = null;
      
      private var _colorSchMgr:IColorSchemeManager;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _userName:String = "";
      
      private var _entryName:String = "";
      
      private var _disposed:Boolean = false;
      
      public function BRMarker()
      {
         this._colorSchMgr = App.colorSchemeMgr;
         this._atlasMgr = App.atlasMgr;
         super();
         this._iconContainer = new Bitmap();
         this.addChild(this._iconContainer);
         this._iconContainer.smoothing = true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._iconContainer = null;
         this._colorSchMgr = null;
         this._atlasMgr = null;
         this.tf = null;
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
      
      public function showVehicleName() : void
      {
      }
      
      public function unhighlight() : void
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
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
