package net.wg.gui.lobby.demoView
{
   import flash.events.TextEvent;
   import flash.text.TextField;
   import net.wg.data.generated.models.DemoSubModel;
   import net.wg.data.generated.models.TextViewModel;
   import net.wg.data.generated.views.DemoViewBase;
   
   public class DemoView extends DemoViewBase
   {
      
      private static const ACTIVE_COLOR:int = 4284272334;
      
      private static const INACTIVE_COLOR:int = 1432145614;
      
      private static const HEADER_HEIGHT:int = 30;
       
      
      public var title:TextField = null;
      
      public var subView:DemoSubView = null;
      
      private var _width:int = 300;
      
      private var _height:int = 200;
      
      private var _isUpdateSize:Boolean = false;
      
      public function DemoView()
      {
         super();
         this.subView.setColor(16777215);
      }
      
      override public function dispose() : void
      {
         this.subView.button2.textField.removeEventListener(TextEvent.TEXT_INPUT,this.onDescrInputHandler);
         this.subView.button3.textField.removeEventListener(TextEvent.TEXT_INPUT,this.onNotesInputHandler);
         this.title = null;
         this.subView.dispose();
         this.subView = null;
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:DemoSubModel = demoViewModel.subView;
         _loc1_.registerIsActiveCallback(this.updateIsActive);
         _loc1_.registerUpdateCounterCallback(this.updateCounter);
         _loc1_.registerUpdateWidthCallback(this.updateWidth);
         _loc1_.registerUpdateHeightCallback(this.updateHeight);
         var _loc2_:TextViewModel = demoViewModel.subView.description;
         _loc2_.registerUpdateStringIDCallback(this.updateDescription);
         _loc2_.registerUpdaTextStyleCallback(this.updateDescription);
         var _loc3_:TextViewModel = demoViewModel.subView.notes;
         _loc3_.registerUpdateStringIDCallback(this.updateNotes);
         _loc3_.registerUpdaTextStyleCallback(this.updateNotes);
         this.subView.button2.textField.addEventListener(TextEvent.TEXT_INPUT,this.onDescrInputHandler);
         this.subView.button3.textField.addEventListener(TextEvent.TEXT_INPUT,this.onNotesInputHandler);
         this.title.text = "Window Title";
      }
      
      override protected function layout() : void
      {
         if(this._isUpdateSize)
         {
            this._isUpdateSize = false;
            this.subView.layout();
            this.updateHeader();
         }
         super.layout();
      }
      
      public function updateDescription() : void
      {
         this.subView.button2.textField.text = demoViewModel.subView.description.getStringID();
      }
      
      public function updateNotes() : void
      {
         this.subView.button3.textField.text = demoViewModel.subView.notes.getStringID();
      }
      
      private function updateHeader() : void
      {
         graphics.clear();
         graphics.beginFill(6082254);
         graphics.drawRect(0,0,this._width,HEADER_HEIGHT);
         graphics.endFill();
         this.title.width = this._width - 10;
      }
      
      private function updateIsActive() : void
      {
         this.subView.alpha = !!demoViewModel.subView.getIsActive() ? Number(1) : Number(0.6);
      }
      
      private function updateCounter() : void
      {
         var _loc1_:int = demoViewModel.subView.getCounter();
         this.subView.button0.setText("Counter value: " + _loc1_);
         this.subView.button1.setText("Duplicated binding for counter value: " + _loc1_);
      }
      
      private function updateWidth() : void
      {
         this._width = demoViewModel.subView.getWidth();
         this.subView.width = this._width;
         this._isUpdateSize = true;
      }
      
      private function updateHeight() : void
      {
         this._height = demoViewModel.subView.getHeight();
         this.subView.height = this._height;
         this._isUpdateSize = true;
      }
      
      private function onNotesInputHandler(param1:TextEvent) : void
      {
         demoViewModel.subView.notes.setStringID(int(this.subView.button3.textField.text));
      }
      
      private function onDescrInputHandler(param1:TextEvent) : void
      {
         demoViewModel.subView.description.setStringID(int(this.subView.button2.textField.text));
      }
   }
}
