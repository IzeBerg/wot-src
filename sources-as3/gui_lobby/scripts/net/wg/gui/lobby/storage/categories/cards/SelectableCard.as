package net.wg.gui.lobby.storage.categories.cards
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   [Event(name="deselect",type="net.wg.gui.lobby.storage.categories.cards.CardEvent")]
   [Event(name="select",type="net.wg.gui.lobby.storage.categories.cards.CardEvent")]
   public class SelectableCard extends BaseCard
   {
      
      private static const CHECKBOX_HIT_AREA_SIZE:int = 18;
       
      
      public var checkbox:SoundButtonEx;
      
      private var _cardHitArea:Sprite;
      
      private var _checkboxHitArea:Sprite;
      
      public function SelectableCard()
      {
         super();
         _resetViewOnDataChange = false;
      }
      
      override protected function onDispose() : void
      {
         this.checkbox.removeEventListener(MouseEvent.CLICK,this.onSelectableCardClickHandler);
         this.checkbox.dispose();
         this.checkbox = null;
         this._cardHitArea = null;
         this._checkboxHitArea = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _overlay.mouseEnabled = _overlay.mouseChildren = false;
         this._cardHitArea = new Sprite();
         this._cardHitArea.name = "hitArea";
         this._cardHitArea.alpha = 0;
         hitArea = this._cardHitArea;
         this._checkboxHitArea = new Sprite();
         this._checkboxHitArea.name = "checkboxHitArea";
         this._checkboxHitArea.alpha = 0;
         this._checkboxHitArea.buttonMode = true;
         this._checkboxHitArea.graphics.clear();
         this._checkboxHitArea.graphics.beginFill(52479,0.5);
         this._checkboxHitArea.graphics.drawRect(0,0,CHECKBOX_HIT_AREA_SIZE,CHECKBOX_HIT_AREA_SIZE);
         this._checkboxHitArea.graphics.endFill();
         this.checkbox.addEventListener(MouseEvent.CLICK,this.onSelectableCardClickHandler);
         this.checkbox.hitArea = this._checkboxHitArea;
         addChildAt(this._checkboxHitArea,0);
         addChildAt(this._cardHitArea,0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(_data && isInvalid(InvalidationType.DATA))
         {
            this.checkbox.selected = _data.selected;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._cardHitArea.graphics;
            _loc1_.clear();
            _loc1_.beginFill(52479,0.5);
            _loc1_.drawRect(0,0,width,height);
            _loc1_.drawRect(width - CHECKBOX_HIT_AREA_SIZE >> 1,-CHECKBOX_HIT_AREA_SIZE >> 1,CHECKBOX_HIT_AREA_SIZE,CHECKBOX_HIT_AREA_SIZE >> 1);
            _loc1_.endFill();
            this._checkboxHitArea.x = width - this._checkboxHitArea.width >> 1;
            this._checkboxHitArea.y = -this._checkboxHitArea.height >> 1;
            this.checkbox.x = width - this.checkbox.width >> 1;
         }
      }
      
      private function onSelectableCardClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isLeftButton(param1))
         {
            param1.stopImmediatePropagation();
            dispatchEvent(new CardEvent(!!selected ? CardEvent.DESELECT : CardEvent.SELECT,_data));
         }
      }
   }
}
