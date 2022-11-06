package net.wg.gui.lobby.questsWindow
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DescriptionBlock extends UIComponentEx
   {
      
      private static const BOTTOM_PADDING:int = 18;
      
      private static const TITLE_PADDING:int = 3;
       
      
      public var lableTF:TextField;
      
      public var descrTF:TextField;
      
      private var _title:String = "";
      
      private var _descr:String = "";
      
      private var _isReadyForLayout:Boolean = false;
      
      public function DescriptionBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = mouseEnabled = false;
      }
      
      public function setLabels(param1:String, param2:String) : void
      {
         this._title = param1;
         this._descr = param2;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.lableTF.htmlText = this._title;
            this.descrTF.htmlText = this._descr;
            this.descrTF.y = Boolean(this._title) ? Number(Math.round(this.lableTF.y + this.lableTF.textHeight + TITLE_PADDING)) : Number(this.lableTF.y);
            _loc1_ = 0;
            if(this._descr)
            {
               _loc1_ = Math.round(this.descrTF.y + this.descrTF.textHeight + BOTTOM_PADDING);
            }
            else if(this._title)
            {
               _loc1_ = Math.round(this.lableTF.y + this.lableTF.textHeight + BOTTOM_PADDING);
            }
            setSize(this.width,_loc1_);
            this.isReadyForLayout = true;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.lableTF = null;
         this.descrTF = null;
         super.onDispose();
      }
      
      public function get isReadyForLayout() : Boolean
      {
         return this._isReadyForLayout;
      }
      
      public function set isReadyForLayout(param1:Boolean) : void
      {
         this._isReadyForLayout = param1;
      }
   }
}
