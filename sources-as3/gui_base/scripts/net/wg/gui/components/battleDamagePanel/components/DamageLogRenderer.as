package net.wg.gui.components.battleDamagePanel.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class DamageLogRenderer extends MovieClip implements IDisposable
   {
      
      private static var _shellTFMaxWidth:Number = -1;
      
      private static const ACTION_TYPE_X_POS:int = 49;
      
      private static const ACTION_ICON_Y_POS:Number = 11;
      
      private static const VEH_ICON_Y_POS:Number = 19;
      
      private static const SHELL_TEXT_PADDING:Number = 6;
      
      private static const SHELL_BG_Y_POS:Number = 13;
      
      private static const SHELL_TYPE_X_POS:Number = 75;
      
      private static const SHELL_TF_X_OFFSET:Number = 1;
      
      public static const SHELL_RIGHT_PADDING:Number = 13;
      
      private static const BLIND_POSTFIX:String = "Blind";
      
      private static const VEH_TF_X_OFFSET:Number = 10;
      
      private static const ICONS_WITH_BLIND:Vector.<String> = new <String>[BATTLEDAMAGELOG_IMAGES.DAMAGELOG_BURN_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_CRITICAL_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_RAM_ENEMY_16X16];
      
      private static const SHELL_TF_BORDER_PADDING:Number = 2;
       
      
      public var externalImagesContainer:Sprite = null;
      
      public var valueTF:TextField = null;
      
      public var actionTypeImg:Sprite = null;
      
      public var shellTypeTF:TextField = null;
      
      public var vehTypeImg:Sprite = null;
      
      public var vehNameTF:TextField = null;
      
      private var _bgImg:Sprite = null;
      
      private var _shellTypeBG:ShellTypeBG = null;
      
      private var _atlasMgr:IAtlasManager = null;
      
      private var _atlasName:String = "";
      
      private var _actionAtlasIconPath:String = "";
      
      private var _isShortMode:Boolean = false;
      
      public function DamageLogRenderer()
      {
         super();
         this._atlasMgr = App.atlasMgr;
      }
      
      public final function dispose() : void
      {
         this._atlasMgr = null;
         this.externalImagesContainer = null;
         this.actionTypeImg = null;
         this.vehTypeImg = null;
         this.shellTypeTF = null;
         this.valueTF = null;
         this.vehNameTF = null;
         this._shellTypeBG.dispose();
         this._shellTypeBG = null;
         this._bgImg = null;
      }
      
      public function init(param1:Sprite, param2:Boolean, param3:Boolean, param4:String) : void
      {
         this._atlasName = param4;
         this._bgImg = new Sprite();
         this.valueTF.autoSize = TextFieldAutoSize.RIGHT;
         this.vehNameTF.autoSize = TextFieldAutoSize.LEFT;
         if(_shellTFMaxWidth <= 0)
         {
            this.calculateShellMaxWidth();
         }
         this.shellTypeTF.width = _shellTFMaxWidth + SHELL_TF_BORDER_PADDING;
         this._shellTypeBG = new ShellTypeBG(param4);
         this.externalImagesContainer = param1;
         this.vehTypeImg = new Sprite();
         this.actionTypeImg = new Sprite();
         this.actionTypeImg.y = ACTION_ICON_Y_POS;
         this._shellTypeBG.y = SHELL_BG_Y_POS;
         this.vehTypeImg.y = VEH_ICON_Y_POS;
         this.updateItemsPositions();
         param1.addChild(this._bgImg);
         param1.addChild(this.vehTypeImg);
         param1.addChild(this.actionTypeImg);
         param1.addChild(this._shellTypeBG);
         this.updateBG(param2,param3);
      }
      
      public function setData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Boolean, param8:Boolean) : void
      {
         this.valueTF.text = param1;
         this._actionAtlasIconPath = param2;
         this.setActionIcon(param7);
         this.shellTypeTF.text = param5;
         this._shellTypeBG.setData(param6);
         if(param3 != Values.EMPTY_STR)
         {
            this._atlasMgr.drawGraphics(this._atlasName,param3,this.vehTypeImg.graphics,Values.EMPTY_STR,false,false,true);
            this.vehNameTF.text = param4;
         }
         if(this._isShortMode != param8)
         {
            this._isShortMode = param8;
            this.updateItemsPositions();
         }
      }
      
      private function updateItemsPositions() : void
      {
         var _loc1_:Number = _shellTFMaxWidth + SHELL_TEXT_PADDING;
         if(!this._isShortMode)
         {
            this._shellTypeBG.updateWidth(_loc1_);
            this._shellTypeBG.x = SHELL_TYPE_X_POS;
            this.shellTypeTF.x = SHELL_TYPE_X_POS + SHELL_TF_X_OFFSET;
         }
         this.shellTypeTF.visible = this._shellTypeBG.visible = !this._isShortMode;
         this.actionTypeImg.x = ACTION_TYPE_X_POS;
         var _loc2_:Number = !this._isShortMode ? Number(SHELL_TYPE_X_POS + _loc1_ + SHELL_RIGHT_PADDING) : Number(SHELL_TYPE_X_POS + SHELL_TF_X_OFFSET);
         this.vehTypeImg.x = _loc2_;
         this.vehNameTF.x = _loc2_ + VEH_TF_X_OFFSET;
      }
      
      public function updateBG(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1 && param2)
         {
            _loc3_ = BATTLEDAMAGELOG_IMAGES.DAMAGE_LOG_DETAIL_TOP;
         }
         else if(param2)
         {
            _loc3_ = BATTLEDAMAGELOG_IMAGES.DAMAGE_LOG_DETAIL_NO_BORDER;
         }
         else
         {
            _loc3_ = BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_DETAIL;
         }
         this._atlasMgr.drawGraphics(this._atlasName,_loc3_,this._bgImg.graphics);
      }
      
      public function updateSettings(param1:Boolean) : void
      {
         this.setActionIcon(param1);
      }
      
      private function setActionIcon(param1:Boolean) : void
      {
         if(this._actionAtlasIconPath == Values.EMPTY_STR)
         {
            return;
         }
         var _loc2_:String = this._actionAtlasIconPath;
         if(param1 && ICONS_WITH_BLIND.indexOf(_loc2_) >= 0)
         {
            _loc2_ += BLIND_POSTFIX;
         }
         this._atlasMgr.drawGraphics(this._atlasName,_loc2_,this.actionTypeImg.graphics);
      }
      
      private function calculateShellMaxWidth() : void
      {
         var _loc1_:Vector.<String> = new <String>[INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING,INGAME_GUI.DAMAGELOG_SHELLTYPE_HIGH_EXPLOSIVE,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING_HE,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING_CR,INGAME_GUI.DAMAGELOG_SHELLTYPE_HOLLOW_CHARGE];
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.shellTypeTF.text = _loc1_[_loc3_];
            _shellTFMaxWidth = Math.max(_shellTFMaxWidth,this.shellTypeTF.textWidth) ^ 0;
            _loc3_++;
         }
      }
   }
}
