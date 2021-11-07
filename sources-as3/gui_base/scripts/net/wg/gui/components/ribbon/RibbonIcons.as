package net.wg.gui.components.ribbon
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.ribbon.data.BackgroundAtlasNames;
   import net.wg.gui.components.ribbon.data.PaddingSettings;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class RibbonIcons extends MovieClip implements IDisposable
   {
      
      private static const RIBBON_TYPE_ICON_X:int = 88;
      
      private static const RIBBON_TYPE_ICON_Y:int = -5;
       
      
      private var _background:Shape = null;
      
      private var _ribbonTypeIcon:Shape = null;
      
      private var _atlasMgr:IAtlasManager = null;
      
      private var _damageSourceIcon:Shape = null;
      
      private var _damageSourceTypeStr:String = null;
      
      private var _isWithVehName:Boolean = false;
      
      private var _isWithRibbonName:Boolean = false;
      
      private var _vehIconPositionWithRibbonName:int = 0;
      
      private var _ribbonSettings:RibbonSettings = null;
      
      public function RibbonIcons()
      {
         super();
         this._atlasMgr = App.atlasMgr;
         this._background = new Shape();
         this._ribbonTypeIcon = new Shape();
         this._ribbonTypeIcon.y = RIBBON_TYPE_ICON_Y;
         this._damageSourceIcon = new Shape();
         addChild(this._background);
         addChild(this._ribbonTypeIcon);
         addChild(this._damageSourceIcon);
         this._damageSourceIcon.visible = false;
      }
      
      public final function dispose() : void
      {
         removeChild(this._background);
         removeChild(this._ribbonTypeIcon);
         removeChild(this._damageSourceIcon);
         this._ribbonSettings = null;
         this._background = null;
         this._ribbonTypeIcon = null;
         this._damageSourceIcon = null;
         this._atlasMgr = null;
      }
      
      public function init(param1:String, param2:RibbonSettings, param3:int) : void
      {
         this._ribbonSettings = param2;
         this._atlasMgr.drawGraphics(param1,this._ribbonSettings.getIcon(),this._ribbonTypeIcon.graphics);
         this._vehIconPositionWithRibbonName = param3;
      }
      
      public function setDamageSourceIcon(param1:String) : void
      {
         if(this._damageSourceIcon != null && this._damageSourceTypeStr != param1)
         {
            this._damageSourceTypeStr = Values.EMPTY_STR;
            this._damageSourceIcon.visible = false;
         }
         if(this._isWithVehName && param1 != Values.EMPTY_STR && this._damageSourceTypeStr != param1)
         {
            this._damageSourceTypeStr = param1;
            this._atlasMgr.drawGraphics(this._ribbonSettings.getAtlas(),this._ribbonSettings.getDamageSourceIcon(this._damageSourceTypeStr),this._damageSourceIcon.graphics);
            this._damageSourceIcon.visible = true;
            this.updateIconsPositions();
         }
      }
      
      public function setSettings(param1:Boolean, param2:Boolean) : void
      {
         this._isWithVehName = param2;
         this._isWithRibbonName = param1;
         if(this._damageSourceIcon != null)
         {
            this._damageSourceIcon.visible = this._damageSourceTypeStr != Values.EMPTY_STR && this._isWithVehName;
         }
         this.updateIconsPositions();
         this.updateIcons();
      }
      
      public function updateIcons() : void
      {
         var _loc1_:BackgroundAtlasNames = this._ribbonSettings.getBackground();
         var _loc2_:String = _loc1_.large;
         if(!this._isWithRibbonName && !this._isWithVehName)
         {
            _loc2_ = _loc1_.small;
         }
         else if(!this._isWithRibbonName || !this._isWithVehName)
         {
            _loc2_ = _loc1_.medium;
         }
         var _loc3_:String = this._ribbonSettings.getAtlas();
         this._atlasMgr.drawGraphics(_loc3_,_loc2_,this._background.graphics);
         this._atlasMgr.drawGraphics(_loc3_,this._ribbonSettings.getIcon(),this._ribbonTypeIcon.graphics);
         this.updateDamageIcon();
      }
      
      private function updateIconsPositions() : void
      {
         var _loc4_:int = 0;
         var _loc1_:PaddingSettings = RibbonSettings.getPaddings(this._isWithRibbonName,this._isWithVehName);
         var _loc2_:Dictionary = RibbonSettings.ICON_X_PADDINGS;
         var _loc3_:Dictionary = RibbonSettings.ICON_Y_PADDINGS;
         this._ribbonTypeIcon.x = RIBBON_TYPE_ICON_X + _loc1_.ribbonIconPaddingX;
         if(this._isWithRibbonName)
         {
            _loc4_ = this._vehIconPositionWithRibbonName;
         }
         else
         {
            _loc4_ = RIBBON_TYPE_ICON_X + this._ribbonTypeIcon.width;
         }
         this._damageSourceIcon.x = _loc4_ + _loc1_.tankIconPaddingX + _loc2_[this._damageSourceTypeStr];
         this._damageSourceIcon.y = _loc3_[this._damageSourceTypeStr];
      }
      
      private function updateDamageIcon() : void
      {
         var _loc1_:String = null;
         if(this._isWithVehName && this._damageSourceIcon != null && this._damageSourceIcon.visible && this._damageSourceTypeStr && this._damageSourceTypeStr != Values.EMPTY_STR)
         {
            _loc1_ = this._ribbonSettings.getAtlas();
            this._atlasMgr.drawGraphics(_loc1_,this._ribbonSettings.getDamageSourceIcon(this._damageSourceTypeStr),this._damageSourceIcon.graphics);
         }
      }
   }
}
