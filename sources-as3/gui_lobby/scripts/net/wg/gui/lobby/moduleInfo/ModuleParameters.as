package net.wg.gui.lobby.moduleInfo
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class ModuleParameters extends UIComponentEx
   {
      
      private static const HEADER_TEXT_INV:String = "headerTextInv";
      
      private static const COUNTER_OFFSET_X:int = -9;
      
      private static const COUNTER_OFFSET_Y:int = -7;
      
      private static const COUNTER_STEP:int = 21;
       
      
      public var header:TextField;
      
      public var paramValue:TextField;
      
      public var paramType:TextField;
      
      private var _bottomMargin:Number;
      
      private var _headerText:String = "";
      
      private var _counterManager:ICounterManager;
      
      private var _parametersHighlightTargets:Vector.<DisplayObject>;
      
      public function ModuleParameters()
      {
         this._counterManager = App.utils.counterManager;
         this._parametersHighlightTargets = new Vector.<DisplayObject>(0);
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.paramType.multiline = true;
         this.paramType.wordWrap = true;
         this.paramType.autoSize = TextFieldAutoSize.LEFT;
         this.paramValue.multiline = true;
         this.paramValue.wordWrap = true;
         this.paramValue.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this._parametersHighlightTargets)
         {
            this._counterManager.removeCounter(_loc1_);
            removeChild(_loc1_);
         }
         this._parametersHighlightTargets.splice(0,this._parametersHighlightTargets.length);
         this._parametersHighlightTargets = null;
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.header = null;
         this.paramValue = null;
         this.paramType = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!StringUtils.isEmpty(this._headerText) && isInvalid(HEADER_TEXT_INV))
         {
            this.header.htmlText = this._headerText;
         }
      }
      
      public function setParameters(param1:Array = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         this.paramValue.htmlText = Values.EMPTY_STR;
         this.paramType.htmlText = Values.EMPTY_STR;
         var _loc2_:int = param1.length;
         if(_loc2_ > 0)
         {
            _loc3_ = 0;
            for each(_loc5_ in param1)
            {
               _loc4_ = this.paramType.numLines;
               TextFieldEx.appendHtml(this.paramType,_loc5_.type);
               TextFieldEx.appendHtml(this.paramValue,_loc5_.value);
               _loc6_ = this.paramType.numLines - _loc4_;
               _loc7_ = _loc6_ == 2;
               if(_loc7_)
               {
                  TextFieldEx.appendHtml(this.paramValue,"\n");
               }
               if(_loc5_.highlight)
               {
                  this.addHighlightCounter(_loc3_);
               }
               _loc3_ += _loc6_;
            }
         }
         height = this.paramValue.y + this.paramValue.height + this._bottomMargin;
      }
      
      private function addHighlightCounter(param1:int) : void
      {
         var _loc2_:Sprite = new Sprite();
         addChild(_loc2_);
         var _loc3_:ICounterProps = new CounterProps(COUNTER_OFFSET_X,this.paramValue.y + COUNTER_OFFSET_Y + COUNTER_STEP * param1,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_BIG_UI);
         this._counterManager.setCounter(_loc2_,CounterManager.COUNTER_EMPTY,null,_loc3_);
         this._parametersHighlightTargets.push(_loc2_);
      }
      
      [Inspectable(defaultValue="0",name="bottomMargin",type="Number")]
      public function get bottomMargin() : Number
      {
         return this._bottomMargin;
      }
      
      public function set bottomMargin(param1:Number) : void
      {
         this._bottomMargin = param1;
      }
      
      public function get headerText() : String
      {
         return this._headerText;
      }
      
      public function set headerText(param1:String) : void
      {
         this._headerText = param1;
         invalidate(HEADER_TEXT_INV);
      }
   }
}
