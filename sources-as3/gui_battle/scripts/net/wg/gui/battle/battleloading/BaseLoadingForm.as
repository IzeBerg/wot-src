package net.wg.gui.battle.battleloading
{
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.StatusIndicator;
   
   public class BaseLoadingForm extends UIComponentEx
   {
      
      private static const PROGRESS:String = "progress";
      
      private static const INVALID_TIP:String = "invalidTip";
      
      private static const MSG_MUST_BE_OVERRIDEN:String = "Method must be overridden!";
       
      
      public var mapText:TextField;
      
      public var battleText:TextField;
      
      public var winText:TextField;
      
      public var loadingBar:StatusIndicator;
      
      public var battleIcon:UILoaderAlt;
      
      public var mapIcon:UILoaderAlt;
      
      public var helpTip:TextField;
      
      public var tipText:TextField;
      
      private var _winTextPosY:int;
      
      private var _battleTextPosY:int;
      
      private var _battleTypeStr:String;
      
      private var _winStr:String;
      
      private var _progress:Number = 0;
      
      private var _mapName:String = "";
      
      private var _battleTypeIconPath:String = "";
      
      private var _tipTitleStr:String = null;
      
      private var _tipBodyStr:String = null;
      
      public function BaseLoadingForm()
      {
         super();
      }
      
      private static function throwAbstractException() : void
      {
         DebugUtils.LOG_ERROR(MSG_MUST_BE_OVERRIDEN);
         throw new AbstractException(MSG_MUST_BE_OVERRIDEN);
      }
      
      public function updateTipBody(param1:String) : void
      {
         if(param1 != this._tipBodyStr)
         {
            this._tipBodyStr = param1;
            invalidate(INVALID_TIP);
         }
      }
      
      public function updateTipTitle(param1:String) : void
      {
         if(param1 != this._tipTitleStr)
         {
            this._tipTitleStr = param1;
            invalidate(INVALID_TIP);
         }
      }
      
      public function updateTipVisibility(param1:Boolean) : void
      {
         this.helpTip.visible = param1;
         this.tipText.visible = param1;
      }
      
      public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         throwAbstractException();
      }
      
      public function getMapComponent() : MinimapPresentation
      {
         throwAbstractException();
         return null;
      }
      
      public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         throwAbstractException();
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         throwAbstractException();
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         throwAbstractException();
      }
      
      public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         throwAbstractException();
      }
      
      public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         throwAbstractException();
      }
      
      public function updateTeamsHeaders(param1:String, param2:String) : void
      {
         throwAbstractException();
      }
      
      public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         throwAbstractException();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            App.utils.commons.truncateTextFieldText(this.battleText,this._battleTypeStr,true,true);
            if(StringUtils.isNotEmpty(this._winStr))
            {
               this.winText.htmlText = this._winStr;
               this.alignHeaderText();
            }
            this.onBattleTextUpdated();
            this.mapText.htmlText = this._mapName;
            this.battleIcon.visible = true;
            this.battleIcon.source = this._battleTypeIconPath;
         }
         if(isInvalid(PROGRESS))
         {
            this.loadingBar.position = this._progress;
         }
         if(isInvalid(INVALID_TIP))
         {
            if(this.helpTip != null && this._tipTitleStr != null)
            {
               this.helpTip.htmlText = this._tipTitleStr;
            }
            this.tipText.htmlText = this._tipBodyStr;
         }
      }
      
      override protected function onDispose() : void
      {
         this.mapText = null;
         this.battleText = null;
         this.winText = null;
         this.loadingBar.dispose();
         this.loadingBar = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         if(this.mapIcon != null)
         {
            this.mapIcon.dispose();
            this.mapIcon = null;
         }
         this.helpTip = null;
         this.tipText = null;
         super.onDispose();
      }
      
      public function getMapIconComponent() : UILoaderAlt
      {
         return this.mapIcon;
      }
      
      public function setBattleTypeIconPath(param1:String) : void
      {
         if(param1 != this._battleTypeIconPath)
         {
            this._battleTypeIconPath = param1;
            invalidateData();
         }
      }
      
      public function setBattleTypeName(param1:String) : void
      {
         if(param1 != this._battleTypeStr)
         {
            this._battleTypeStr = param1;
            invalidateData();
         }
      }
      
      public function setMapIcon(param1:String) : void
      {
         if(param1 != this.mapIcon.source)
         {
            this.mapIcon.source = param1;
         }
      }
      
      public function updateMapName(param1:String) : void
      {
         if(param1 != this._mapName)
         {
            this._mapName = param1;
            invalidateData();
         }
      }
      
      public function updateProgress(param1:Number) : void
      {
         if(param1 != this._progress)
         {
            this._progress = param1;
            invalidate(PROGRESS);
         }
      }
      
      public function updateWinText(param1:String) : void
      {
         var _loc2_:int = 0;
         if(param1 != this._winStr)
         {
            this._winStr = param1;
            if(param1.length > 0)
            {
               _loc2_ = this.winText.height >> 1;
               this._winTextPosY = this.winText.y + _loc2_;
               this._battleTextPosY = this.battleText.y + _loc2_;
            }
            invalidateData();
         }
      }
      
      protected function onBattleTextUpdated() : void
      {
      }
      
      protected function alignHeaderText() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this.winText.textHeight >> 1;
         this.winText.y = this._winTextPosY - _loc1_;
         this.battleText.y = this._battleTextPosY - _loc1_;
      }
      
      protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.RANDOM;
      }
   }
}
