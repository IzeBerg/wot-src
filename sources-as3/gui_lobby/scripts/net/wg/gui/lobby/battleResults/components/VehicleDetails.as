package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.lobby.battleResults.data.StatItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICommons;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class VehicleDetails extends UIComponentEx
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_TIME:String = "time";
      
      public static const STATE_WIDE:String = "wide";
      
      public static const STATE_EPIC:String = "epic";
      
      private static const WIDE_LBL_WIDTH:int = 300;
      
      private static const WIDE_VALUES_POS_X:int = 306;
      
      private static const WIDE_VALUES_POS_Y:int = 0;
      
      private static const WIDE_VALUES_WIDTH:int = 130;
      
      private static const WIDE_WIDTH:int = 436;
      
      private static const TIME_LBL_WIDTH:int = 254;
      
      private static const TIME_VALUES_POS_X:int = 262;
      
      private static const TIME_VALUES_POS_Y:int = 2;
      
      private static const TIME_VALUES_WIDTH:int = 100;
      
      private static const TIME_WIDTH:int = 362;
      
      private static const EPIC_LBL_WIDTH:int = 286;
      
      private static const EPIC_VALUES_POS_X:int = 288;
      
      private static const EPIC_VALUES_POS_Y:int = 2;
      
      private static const EPIC_VALUES_WIDTH:int = 57;
      
      private static const EPIC_WIDTH:int = 345;
      
      private static const DEFAULT_LBL_WIDTH:int = 300;
      
      private static const DEFAULT_VALUES_POS_X:int = 302;
      
      private static const DEFAULT_VALUES_POS_Y:int = 2;
      
      private static const DEFAULT_VALUES_WIDTH:int = 60;
      
      private static const DEFAULT_WIDTH:int = 362;
      
      private static const TINY_OFFSET:int = 3;
      
      private static const INFO_ICON_OFFSET_X:int = -3;
      
      private static const INFO_ICON_OFFSET_Y:int = -8;
       
      
      public var statsLbl:TextField;
      
      public var statsValuesLbl:TextField;
      
      private var _linesContainer:MovieClip;
      
      private var _infoIconsContainer:Sprite = null;
      
      private var _lineType:String = "statsLineUI";
      
      private var _data:Vector.<StatItemVO>;
      
      private var _dataDirty:Boolean = false;
      
      private var _state:String = "normal";
      
      private var _stateDirty:Boolean = false;
      
      public function VehicleDetails()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.clearLines();
         this.clearInfoIcons();
         this.statsLbl.mouseWheelEnabled = false;
         this.statsValuesLbl.mouseWheelEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.statsLbl = null;
         this.statsValuesLbl = null;
         this._linesContainer = null;
         this._infoIconsContainer = null;
         this._lineType = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._stateDirty)
         {
            if(this.state == STATE_WIDE)
            {
               this.statsLbl.width = WIDE_LBL_WIDTH;
               this.statsValuesLbl.x = WIDE_VALUES_POS_X;
               this.statsValuesLbl.y = WIDE_VALUES_POS_Y;
               this.statsValuesLbl.width = WIDE_VALUES_WIDTH;
               this._lineType = Linkages.BATTLE_RESULTS_STATS_LINE_WIDE;
               width = WIDE_WIDTH;
            }
            else if(this.state == STATE_TIME)
            {
               this.statsLbl.width = TIME_LBL_WIDTH;
               this.statsValuesLbl.x = TIME_VALUES_POS_X;
               this.statsValuesLbl.y = TIME_VALUES_POS_Y;
               this.statsValuesLbl.width = TIME_VALUES_WIDTH;
               this._lineType = Linkages.BATTLE_RESULTS_STATS_LINE;
               width = TIME_WIDTH;
            }
            else if(this.state == STATE_EPIC)
            {
               this.statsLbl.width = EPIC_LBL_WIDTH;
               this.statsValuesLbl.x = EPIC_VALUES_POS_X;
               this.statsValuesLbl.y = EPIC_VALUES_POS_Y;
               this.statsValuesLbl.width = EPIC_VALUES_WIDTH;
               this._lineType = Linkages.BATTLE_RESULTS_STATS_LINE_EPIC;
               width = EPIC_WIDTH;
            }
            else
            {
               this.statsLbl.width = DEFAULT_LBL_WIDTH;
               this.statsValuesLbl.x = DEFAULT_VALUES_POS_X;
               this.statsValuesLbl.y = DEFAULT_VALUES_POS_Y;
               this.statsValuesLbl.width = DEFAULT_VALUES_WIDTH;
               this._lineType = Linkages.BATTLE_RESULTS_STATS_LINE;
               width = DEFAULT_WIDTH;
            }
            initSize();
            this._stateDirty = false;
         }
         if(this._dataDirty)
         {
            this.populateStats(this.data);
            this._dataDirty = false;
         }
      }
      
      private function populateStats(param1:Vector.<StatItemVO>) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:StatItemVO = null;
         var _loc5_:MovieClip = null;
         var _loc6_:InfoIcon = null;
         var _loc7_:IUtils = null;
         var _loc8_:ICommons = null;
         var _loc9_:IClassFactory = null;
         this.statsLbl.htmlText = Values.EMPTY_STR;
         this.statsValuesLbl.htmlText = Values.EMPTY_STR;
         this.clearLines();
         this.clearInfoIcons();
         if(param1 != null)
         {
            _loc2_ = 0;
            _loc3_ = param1.length;
            _loc7_ = App.utils;
            _loc8_ = _loc7_.commons;
            _loc9_ = _loc7_.classFactory;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = param1[_loc2_];
               _loc8_.addBlankLines(_loc4_.label,this.statsLbl,Vector.<TextField>([this.statsValuesLbl]));
               this.statsLbl.htmlText += _loc4_.label;
               this.statsValuesLbl.htmlText += _loc4_.value;
               App.utils.commons.updateTextFieldSize(this.statsLbl,false,true);
               if(Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + TINY_OFFSET < this.statsLbl.height)
               {
                  _loc5_ = _loc9_.getComponent(this._lineType,MovieClip,{
                     "x":this.statsLbl.x + TINY_OFFSET,
                     "y":Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + TINY_OFFSET
                  });
                  this._linesContainer.addChild(_loc5_);
               }
               if(StringUtils.isNotEmpty(_loc4_.infoTooltip))
               {
                  _loc6_ = InfoIcon(App.utils.classFactory.getComponent(Linkages.INFO_ICON_UI,InfoIcon,{
                     "x":this.statsValuesLbl.x + this.statsValuesLbl.width + INFO_ICON_OFFSET_X | 0,
                     "y":this.statsValuesLbl.y + this.statsLbl.textHeight + INFO_ICON_OFFSET_Y | 0
                  }));
                  _loc6_.tooltip = _loc4_.infoTooltip;
                  this._infoIconsContainer.addChild(_loc6_);
               }
               _loc2_++;
            }
         }
         App.utils.commons.updateTextFieldSize(this.statsValuesLbl,false,true);
         _height = this.statsLbl.y + this.statsLbl.height > this.statsValuesLbl.height ? Number(this.statsLbl.height) : Number(this.statsValuesLbl.height);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function clearLines() : void
      {
         if(this._linesContainer)
         {
            removeChild(this._linesContainer);
         }
         this._linesContainer = new MovieClip();
         addChild(this._linesContainer);
      }
      
      private function clearInfoIcons() : void
      {
         if(this._infoIconsContainer)
         {
            removeChild(this._infoIconsContainer);
         }
         this._infoIconsContainer = new Sprite();
         addChild(this._infoIconsContainer);
      }
      
      public function get data() : Vector.<StatItemVO>
      {
         return this._data;
      }
      
      public function set data(param1:Vector.<StatItemVO>) : void
      {
         this._data = param1;
         this._dataDirty = true;
         invalidate();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
         this._stateDirty = true;
         invalidate();
      }
   }
}
