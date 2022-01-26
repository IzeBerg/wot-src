package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ResizableTileList;
   import net.wg.gui.events.ListEventEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class CrewSkinsBlock extends UIComponentEx
   {
       
      
      public var title:TextField;
      
      public var tileList:ResizableTileList;
      
      private var _dataProvider:DataProvider;
      
      private var _labelText:String = "";
      
      private var _isReady:Boolean;
      
      public function CrewSkinsBlock()
      {
         super();
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(Event.RESIZE,this.tileResizeHandler,false,0,true);
         this.tileList.addEventListener(ListEventEx.UPDATE_COMPLETE,this.listUpdateCompleteHandler);
         this.tileList.direction = DirectionMode.VERTICAL;
         this.tileList.columnCount = 4;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.title.text = this._labelText;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applySizeChanges();
         }
      }
      
      override protected function onDispose() : void
      {
         this.tileList.removeEventListener(ListEventEx.UPDATE_COMPLETE,this.listUpdateCompleteHandler);
         this.tileList.dispose();
         this.tileList = null;
         this.title = null;
         this._dataProvider = null;
         super.onDispose();
      }
      
      public function get dataProvider() : DataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:DataProvider) : void
      {
         if(this._dataProvider != param1)
         {
            this._isReady = false;
            this._dataProvider = param1;
            this.tileList.dataProvider = this._dataProvider;
         }
      }
      
      public function set labelText(param1:String) : void
      {
         this._labelText = param1;
         invalidate(InvalidationType.DATA);
      }
      
      private function applySizeChanges() : void
      {
         _height = this.tileList.y + this.tileList.height;
      }
      
      private function tileResizeHandler(param1:Event) : void
      {
         this.applySizeChanges();
      }
      
      private function listUpdateCompleteHandler(param1:ListEventEx) : void
      {
         this._isReady = true;
      }
   }
}
