package net.wg.gui.lobby.modulesPanel.components
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.modulesPanel.data.ModuleVO;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICommons;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ModuleFittingItemRenderer extends FittingListItemRenderer
   {
      
      private static const COUNTER_LINE_BIG_UI_HEIGHT:int = 42;
      
      private static const COUNTER_LINE_BIG_UI_OFFSET:Number = 2.5;
       
      
      public var levelIcon:MovieClip;
      
      public var paramValuesField:TextField;
      
      public var paramNamesField:TextField;
      
      private var _moduleData:ModuleVO;
      
      private var _counterManager:ICounterManager;
      
      private var _commons:ICommons;
      
      public function ModuleFittingItemRenderer()
      {
         this._counterManager = App.utils.counterManager;
         this._commons = App.utils.commons;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._moduleData = ModuleVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this.levelIcon = null;
         this._counterManager = null;
         this._commons = null;
         this.paramValuesField = null;
         this.paramNamesField = null;
         this._moduleData = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         this._counterManager.removeCounter(this);
         super.onBeforeDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.levelIcon.mouseEnabled = this.levelIcon.mouseChildren = false;
         this.paramValuesField.mouseEnabled = false;
         this.paramNamesField.mouseEnabled = false;
      }
      
      override protected function setup() : void
      {
         var _loc1_:String = null;
         var _loc2_:ICounterProps = null;
         super.setup();
         if(this._moduleData != null)
         {
            this.paramNamesField.htmlText = this._moduleData.paramNames;
            this.paramValuesField.htmlText = this._moduleData.paramValues;
            this.levelIcon.gotoAndStop(this._moduleData.level);
            this._commons.updateTextFieldSize(this.paramValuesField,false,true);
            this._commons.updateTextFieldSize(this.paramNamesField,false,true);
            layoutErrorField(this.paramNamesField);
            _loc1_ = this._moduleData.extraModuleInfo;
            if(StringUtils.isEmpty(_loc1_))
            {
               moduleType.hideExtraIcon();
            }
            else
            {
               moduleType.showExtraIcon();
               moduleType.setExtraIconBySource(_loc1_);
            }
            if(this._moduleData.highlightedParameterIdx > Values.DEFAULT_INT)
            {
               _loc2_ = new CounterProps(CounterProps.DEFAULT_OFFSET_X,this.paramNamesField.y + this.getHighlightOffset(this._moduleData.highlightedParameterIdx),TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_BIG_UI);
               this._counterManager.setCounter(this,CounterManager.COUNTER_EMPTY,null,_loc2_);
            }
         }
      }
      
      private function getHighlightOffset(param1:int) : int
      {
         var _loc2_:int = this.paramNamesField.getLineOffset(param1);
         var _loc3_:Rectangle = this.paramNamesField.getCharBoundaries(_loc2_);
         var _loc4_:Number = _loc3_.top + (_loc3_.height - COUNTER_LINE_BIG_UI_HEIGHT) * 0.5;
         _loc4_ += COUNTER_LINE_BIG_UI_OFFSET;
         return Math.round(_loc4_);
      }
   }
}
