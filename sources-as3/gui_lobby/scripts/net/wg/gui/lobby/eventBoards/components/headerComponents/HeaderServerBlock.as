package net.wg.gui.lobby.eventBoards.components.headerComponents
{
   import flash.events.IEventDispatcher;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.data.HeaderServerBlockVO;
   import net.wg.gui.lobby.eventBoards.events.ServerEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class HeaderServerBlock extends UIComponentEx
   {
      
      private static const BUTTON_WIDTH:int = 120;
      
      private static const BUTTON_OFFSET:int = 20;
      
      private static const SERVER_CLICK:String = "serverClick";
       
      
      public var title:TextField = null;
      
      public var btn1:ISoundButtonEx = null;
      
      public var btn2:ISoundButtonEx = null;
      
      public var btn3:ISoundButtonEx = null;
      
      public var btn4:ISoundButtonEx = null;
      
      private var _groups:Vector.<ISoundButtonEx> = null;
      
      private var _data:HeaderServerBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _eventID:String = "";
      
      public function HeaderServerBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this._groups = new <ISoundButtonEx>[this.btn1,this.btn2,this.btn3,this.btn4];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:ISoundButtonEx = null;
         super.configUI();
         for each(_loc1_ in this._groups)
         {
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onGroupClickHandler);
            _loc1_.usePreventUpdateTextScale = true;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ISoundButtonEx = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            if(this._data.buttons)
            {
               _loc1_ = this._data.buttons.length;
               _loc3_ = 0;
               for each(_loc2_ in this._groups)
               {
                  if(_loc1_ > 0)
                  {
                     _loc2_.visible = true;
                     _loc3_ += BUTTON_WIDTH + BUTTON_OFFSET;
                     _loc1_--;
                  }
                  else
                  {
                     _loc2_.visible = false;
                  }
               }
               _loc3_ -= BUTTON_OFFSET;
               _loc4_ = 0;
               _loc5_ = -(_loc3_ >> 1);
               for each(_loc2_ in this._groups)
               {
                  if(_loc2_.visible)
                  {
                     _loc2_.x = _loc5_;
                     _loc2_.label = this._data.buttons[_loc4_].label;
                     _loc2_.tooltip = this._data.buttons[_loc4_].tooltip;
                     _loc5_ += BUTTON_WIDTH + BUTTON_OFFSET;
                     _loc4_++;
                  }
               }
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:IEventDispatcher = null;
         for each(_loc1_ in this._groups)
         {
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onGroupClickHandler);
         }
         this._groups.splice(0,this._groups.length);
         this._groups = null;
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.btn1.dispose();
         this.btn1 = null;
         this.btn2.dispose();
         this.btn2 = null;
         this.btn3.dispose();
         this.btn3 = null;
         this.btn4.dispose();
         this.btn4 = null;
         this._data = null;
         this._toolTipMgr = null;
         this._eventID = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = HeaderServerBlockVO(param1);
            invalidateData();
         }
      }
      
      public function setEventID(param1:String) : void
      {
         this._eventID = param1;
      }
      
      private function onGroupClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            _loc2_ = this._groups.indexOf(ISoundButtonEx(param1.currentTarget));
            dispatchEvent(new ServerEvent(SERVER_CLICK,this._eventID,this._data.buttons[_loc2_].server,true));
         }
      }
   }
}
