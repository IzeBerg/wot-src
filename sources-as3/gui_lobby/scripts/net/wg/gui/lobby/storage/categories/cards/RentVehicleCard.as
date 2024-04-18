package net.wg.gui.lobby.storage.categories.cards
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class RentVehicleCard extends BaseCard
   {
       
      
      public var rentTF:TextField;
      
      public var rentIcon:Image;
      
      public function RentVehicleCard()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.rentTF = null;
         this.rentIcon.removeEventListener(Event.CHANGE,this.onRentIconCompleteHandler);
         this.rentIcon.dispose();
         this.rentIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         sellButton.label = STORAGE.BUTTONLABEL_REMOVE;
         this.rentTF.autoSize = TextFieldAutoSize.LEFT;
         this.rentTF.mouseWheelEnabled = this.rentTF.mouseEnabled = false;
         this.rentTF.wordWrap = false;
         this.rentIcon.mouseEnabled = this.rentIcon.mouseChildren = false;
         this.rentIcon.addEventListener(Event.CHANGE,this.onRentIconCompleteHandler);
         _container.addChild(this.rentTF);
         _container.addChild(this.rentIcon);
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehicleCardVO = null;
         var _loc2_:Rectangle = null;
         super.draw();
         if(_data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = VehicleCardVO(_data);
            if(_loc1_.rentText)
            {
               this.rentTF.text = _loc1_.rentText;
               this.rentTF.visible = true;
               this.rentIcon.source = _loc1_.rentIcon;
               this.rentIcon.visible = true;
            }
            else
            {
               this.rentTF.visible = false;
               this.rentIcon.visible = false;
            }
         }
         if(_data && isInvalid(InvalidationType.SIZE))
         {
            _loc2_ = _sizeVO.innerPadding;
            if(this.rentTF.visible)
            {
               this.rentTF.y = titleTF.y + titleTF.height + _sizeVO.descriptionOffset;
               this.rentTF.width = _loc2_.width - this.rentTF.x >> 0;
               if(this.rentIcon.ready)
               {
                  this.rentIcon.y = this.rentTF.y + (this.rentTF.height - this.rentIcon.height >> 1);
               }
            }
            if(!_isOver)
            {
               _container.y = this.getContainerYRolloutPosition();
            }
         }
      }
      
      override protected function getContainerYRolloutPosition() : int
      {
         return _sizeVO.innerPadding.bottom - (this.rentTF.y + this.rentTF.height) >> 0;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isRightButton(param1))
         {
            if(_data.contextMenuId)
            {
               dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,_data));
            }
         }
         else if(_data.enabled)
         {
            dispatchEvent(new CardEvent(CardEvent.REMOVE,_data));
         }
      }
      
      private function onRentIconCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
