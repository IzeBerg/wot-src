package net.wg.gui.bootcamp.nationsWindow.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.nationsWindow.data.NationItemVO;
   import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.events.ButtonEvent;
   
   public class NationsSelectorContainer extends MovieClip implements IDisposable
   {
       
      
      public var selectItem:MovieClip = null;
      
      public var btnUsa:NationButton = null;
      
      public var btnGe:NationButton = null;
      
      public var btnUssr:NationButton = null;
      
      public var bottomBG:MovieClip = null;
      
      private var _selectedNation:int = 0;
      
      private var _nationButtons:Vector.<NationButton>;
      
      public function NationsSelectorContainer()
      {
         this._nationButtons = new Vector.<NationButton>();
         super();
         this._nationButtons.push(this.btnUssr,this.btnGe,this.btnUsa);
         this.configUI();
      }
      
      public final function dispose() : void
      {
         this._nationButtons.splice(0,this._nationButtons.length);
         this._nationButtons = null;
         this.btnUsa.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnGe.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnUssr.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.selectItem = null;
         this.btnUsa.dispose();
         this.btnUsa = null;
         this.btnGe.dispose();
         this.btnGe = null;
         this.btnUssr.dispose();
         this.btnUssr = null;
         this.bottomBG = null;
      }
      
      public function selectNation(param1:int) : void
      {
         this._selectedNation = param1;
         if(this._nationButtons.length > param1)
         {
            this.selectItem.x = this._nationButtons[param1].x;
         }
      }
      
      public function setNationsOrder(param1:Vector.<NationItemVO>) : void
      {
         var _loc4_:NationButton = null;
         var _loc5_:NationItemVO = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._nationButtons[_loc3_];
            _loc5_ = param1[_loc3_];
            _loc4_.setSource(_loc5_.icon);
            _loc4_.label = _loc5_.label;
            _loc3_++;
         }
      }
      
      public function setWidth(param1:int) : void
      {
         this.bottomBG.width = param1;
         this.bottomBG.x = -param1 >> 1;
      }
      
      protected function configUI() : void
      {
         this.btnUsa.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnGe.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnUssr.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.selectItem.mouseEnabled = this.selectItem.mouseChildren = this.bottomBG.mouseEnabled = this.bottomBG.mouseChildren = false;
      }
      
      private function onBtnNationClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:SoundButtonEx = SoundButtonEx(param1.currentTarget);
         var _loc3_:uint = this._nationButtons.indexOf(_loc2_);
         if(_loc3_ == this._selectedNation)
         {
            return;
         }
         this.selectNation(_loc3_);
         dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SHOW,this._selectedNation));
      }
   }
}
