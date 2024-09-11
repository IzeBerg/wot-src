package net.wg.gui.battle.epicBattle.views.upgradePanel
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.epicBattle.views.upgradePanel.data.EpicModuleInfoVO;
   import net.wg.gui.components.hintPanel.KeyViewersList;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class EpicModuleInfo extends UIComponent
   {
      
      public static const TEXT_ORIENTATION_LEFT:int = 0;
      
      public static const TEXT_ORIENTATION_RIGHT:int = 1;
      
      private static const TEXT_FIELD_PADDING:int = 4;
      
      private static const MODULE_BIG_OFFSET_X:int = 18;
      
      private static const MODULE_SMALL_OFFSET_X:int = 9;
      
      private static const ICON_OFFSET_X:int = 2;
      
      private static const KEYS_OFFSET_X:int = 9;
      
      private static const KEYS_OFFSET_X_BIG:int = -13;
      
      private static const KEYS_BIG_OFFSET_Y:int = 18;
      
      private static const KEYS_FROM_DESCR_OFFSET_Y:int = 18;
      
      private static const KEY_VIEWER_LINKAGE:String = "ModuleInfoKeyViewerUI";
      
      private static const KEY_VIEWER_KEY_GAP:int = 16;
      
      private static const KEY_SIDE_OFFSET:int = 8;
      
      private static const MAX_LINES:uint = 2;
       
      
      public var headerTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var category:MovieClip = null;
      
      private var _textOrientation:int = -1;
      
      private var _moduleIdx:int = -1;
      
      private var _keyViewerList:KeyViewersList = null;
      
      private var _module:EpicConfiguratorRenderer = null;
      
      private var _isBig:Boolean = true;
      
      private var _isInited:Boolean = false;
      
      private var _moduleHitArea:Sprite = null;
      
      private var _hitMc:Sprite = null;
      
      public function EpicModuleInfo()
      {
         super();
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this._keyViewerList = new KeyViewersList();
         this._keyViewerList.keyClass = getDefinitionByName(KEY_VIEWER_LINKAGE) as Class;
         this._keyViewerList.keyGap = KEY_VIEWER_KEY_GAP;
         this._keyViewerList.keySideOffset = KEY_SIDE_OFFSET;
         this.addChild(this._keyViewerList);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.SETTINGS))
         {
            _loc1_ = !!this._isBig ? Linkages.CONFIGURATOR_RENDERER_BIG : Linkages.CONFIGURATOR_RENDERER_SMALL;
            this._module = App.utils.classFactory.getComponent(_loc1_,IEpicConfiguratorRenderer);
            this._module.setIndex(EpicConfiguratorRenderer.START_COLUMN_INDEX,this._moduleIdx);
            this._module.hitArea = this._moduleHitArea = this._hitMc;
            this.addChild(this._module);
            this._module.visible = visible;
            App.utils.commons.updateChildrenMouseBehavior(this,false,false,new <DisplayObject>[this._module]);
            this._isInited = true;
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeChild(this._keyViewerList);
         this._keyViewerList.dispose();
         this._keyViewerList = null;
         if(this._isInited)
         {
            this.removeChild(this._module);
            this._module.dispose();
            this._module = null;
         }
         this.headerTF = null;
         this.descriptionTF = null;
         this.category = null;
         this._moduleHitArea = null;
         this._hitMc = null;
         super.onDispose();
      }
      
      public function initSettings(param1:int, param2:Boolean, param3:int, param4:Sprite = null) : void
      {
         this._textOrientation = param1;
         this._isBig = param2;
         this._moduleIdx = param3;
         this._hitMc = param4;
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function setData(param1:EpicModuleInfoVO) : void
      {
         App.utils.asserter.assert(this._isInited,"You must call initSettings before calling setData");
         this.headerTF.text = param1.header;
         App.utils.commons.truncateTextFieldMultiline(this.descriptionTF,param1.description,MAX_LINES,Values.THREE_DOTS);
         this._module.setData(param1.module);
         if(StringUtils.isNotEmpty(param1.category))
         {
            this.category.gotoAndStop(param1.category);
         }
         else
         {
            this.category.visible = false;
         }
         this.updatePositions();
         this.updateKeyViewerPosition();
      }
      
      public function setHotKeys(param1:Array, param2:Array) : void
      {
         this._keyViewerList.setKeys(param1,param2);
      }
      
      private function updateKeyViewerPosition() : void
      {
         var _loc2_:int = 0;
         if(this._textOrientation == TEXT_ORIENTATION_LEFT)
         {
            _loc2_ = !!this._isBig ? int(KEYS_OFFSET_X_BIG) : int(KEYS_OFFSET_X);
            this._keyViewerList.x = this._module.x + this._module.width - this._keyViewerList.width - _loc2_;
         }
         else
         {
            this._keyViewerList.x = this._module.x + KEYS_OFFSET_X;
         }
         var _loc1_:int = !!this._isBig ? int(KEYS_BIG_OFFSET_Y) : int(0);
         _loc1_ += Math.max(this.descriptionTF.y + this.descriptionTF.height + KEYS_FROM_DESCR_OFFSET_Y,this._module.y + this._module.height);
         this._keyViewerList.y = _loc1_;
      }
      
      private function updatePositions() : void
      {
         var _loc3_:Rectangle = null;
         var _loc1_:Boolean = this._textOrientation == TEXT_ORIENTATION_LEFT;
         var _loc2_:Number = !!this._isBig ? Number(MODULE_BIG_OFFSET_X) : Number(MODULE_SMALL_OFFSET_X);
         _loc3_ = this._module.getBounds(this._module);
         var _loc4_:int = !!_loc1_ ? int(-_loc3_.width) : int(0);
         if(_loc1_)
         {
            this.headerTF.x = Math.round(_loc4_ - this.headerTF.width - _loc2_);
            this.category.x = Math.round(this.headerTF.x - this.category.width + TEXT_FIELD_PADDING);
            this.descriptionTF.x = Math.round(_loc4_ - this.descriptionTF.width - _loc2_);
            this.descriptionTF.autoSize = TextFieldAutoSize.RIGHT;
         }
         else
         {
            this.category.x = Math.round(_loc3_.width + ICON_OFFSET_X);
            this.headerTF.x = Math.round(this.category.x + this.category.width - TEXT_FIELD_PADDING);
            this.descriptionTF.x = Math.round(_loc3_.width + _loc2_);
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         }
         this._module.x = _loc4_ - _loc3_.x | 0;
      }
      
      public function get intCD() : uint
      {
         return this._module.moduleIntCD;
      }
      
      public function get keyViewerPositionY() : Number
      {
         return this._keyViewerList.y;
      }
      
      public function set keyViewerPositionY(param1:Number) : void
      {
         this._keyViewerList.y = param1 | 0;
      }
      
      public function set hoverEnabled(param1:Boolean) : void
      {
         if(this._module && this._moduleHitArea)
         {
            this._module.hitArea = !!param1 ? this._moduleHitArea : null;
         }
      }
   }
}
