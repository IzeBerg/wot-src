package net.wg.gui.messenger.controls
{
   import flash.events.Event;
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class ContactAttributesGroup extends Group
   {
       
      
      private var _dataProvider:Vector.<String> = null;
      
      private var _created:Vector.<IImage> = null;
      
      public function ContactAttributesGroup()
      {
         this._created = new Vector.<IImage>();
         super();
      }
      
      override public function removeAllChildren(param1:Boolean = false) : void
      {
         this.clearCreated();
         super.removeAllChildren(param1);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this._dataProvider)
         {
            this.applyNewChildren();
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         this.clearCreated();
         this._created.splice(0,this._created.length);
         this._created = null;
         super.onDispose();
      }
      
      public function setDataProvider(param1:Vector.<String>) : void
      {
         this.clearData();
         this._dataProvider = param1;
         invalidateData();
      }
      
      private function clearData() : void
      {
         if(this._dataProvider)
         {
            this._dataProvider.splice(0,this._dataProvider.length);
            this._dataProvider = null;
         }
      }
      
      private function clearCreated() : void
      {
         var _loc1_:IImage = null;
         for each(_loc1_ in this._created)
         {
            _loc1_.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         }
      }
      
      private function applyNewChildren() : void
      {
         var _loc1_:String = null;
         var _loc2_:Image = null;
         this.removeAllChildren();
         for each(_loc1_ in this._dataProvider)
         {
            _loc2_ = new Image();
            this._created.push(_loc2_);
            _loc2_.addEventListener(Event.CHANGE,this.onImgChangeHandler);
            _loc2_.source = _loc1_;
            addChild(_loc2_);
         }
         invalidateLayout();
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
