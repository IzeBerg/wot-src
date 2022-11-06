package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.daapi.DAAPIArenaHeaderInfoVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.gfx.TextFieldEx;
   
   public class FullStatsHeader extends BattleDisplayable implements IDisposable, IUpdatable
   {
      
      private static const BATTLE_ICON_X:int = -69;
      
      private static const BATTLE_ICON_Y:int = 4;
      
      private static const BATTLE_ICON_SMALL_X:int = -32;
      
      private static const BATTLE_ICON_SMALL_Y:int = 17;
      
      private static const MAP_TF_Y:int = 55;
      
      private static const BATTLE_TF_Y:int = 45;
      
      private static const WIN_TF_Y:int = 70;
      
      private static const TF_SMALL_Y_SHIFT:int = 21;
      
      private static const MAP_TF_X:int = -503;
      
      private static const BATTLE_TF_X:int = 65;
      
      private static const TF_SMALL_X_SHIFT:int = 27;
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const SMALL_STATE:String = "small";
       
      
      public var battleIcon:UILoaderAlt = null;
      
      public var mapTF:TextField = null;
      
      public var battleTF:TextField = null;
      
      public var winTF:TextField = null;
      
      public var headerBg:MovieClip = null;
      
      private var _data:DAAPIArenaHeaderInfoVO = null;
      
      private var _height:Number;
      
      private var _minHeight:uint;
      
      private var _leftSideSmallYShift:int = 21;
      
      public function FullStatsHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.mapTF,true);
         TextFieldEx.setNoTranslate(this.battleTF,true);
         TextFieldEx.setNoTranslate(this.winTF,true);
         this.winTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.mapTF = null;
         this.battleTF = null;
         this.winTF = null;
         this.headerBg = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setMinHeight(param1:uint) : void
      {
         this._minHeight = param1;
      }
      
      public function setLeftSideSmallYShift(param1:int) : void
      {
         this._leftSideSmallYShift = param1;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = DAAPIArenaHeaderInfoVO(param1);
            this.mapTF.text = this._data.mapName;
            this.battleTF.text = this._data.battleTypeLocaleStr;
            this.winTF.text = this._data.winText;
         }
      }
      
      public function updateSize(param1:Number, param2:Number) : void
      {
         this._height = param2;
         this.mapTF.y = MAP_TF_Y;
         this.battleTF.y = BATTLE_TF_Y;
         this.winTF.y = WIN_TF_Y;
         this.mapTF.x = MAP_TF_X;
         this.battleTF.x = BATTLE_TF_X;
         if(param2 < this._minHeight)
         {
            this.mapTF.y -= TF_SMALL_Y_SHIFT;
            this.battleTF.y -= this._leftSideSmallYShift;
            this.winTF.y -= this._leftSideSmallYShift;
            this.mapTF.x += TF_SMALL_X_SHIFT;
            this.battleTF.x -= TF_SMALL_X_SHIFT;
         }
         this.winTF.x = this.battleTF.x;
         this.headerBg.gotoAndStop(param2 < this._minHeight ? SMALL_STATE : NORMAL_STATE);
         this.updateBattleIcon();
      }
      
      private function updateBattleIcon() : void
      {
         if(this.battleIcon == null || this._data == null)
         {
            return;
         }
         if(this._height < this._minHeight)
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_64x64_all_png(this._data.battleTypeFrameLabel);
            this.battleIcon.x = BATTLE_ICON_SMALL_X;
            this.battleIcon.y = BATTLE_ICON_SMALL_Y;
         }
         else
         {
            this.battleIcon.source = RES_ICONS.maps_icons_battletypes_136x136_all_png(this._data.battleTypeFrameLabel);
            this.battleIcon.x = BATTLE_ICON_X;
            this.battleIcon.y = BATTLE_ICON_Y;
         }
      }
   }
}
