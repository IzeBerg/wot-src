package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data.BattleRoyalePlatoonVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class BattleRoyalePlatoonRenderer extends MovieClip implements IListItemRenderer, IDisposable
   {
      
      private static const ENEMY:String = "tank_small_platoon";
      
      private static const ALLY:String = "tank_small_platoon_squad";
      
      private static const DEFAULT_ALPHA:Number = 1;
      
      private static const DESTROYED_ALPHA:Number = 0.2;
       
      
      public var icon:BattleAtlasSprite = null;
      
      private var _index:uint = 0;
      
      private var _platoonData:BattleRoyalePlatoonVO = null;
      
      private var _isDisposed:Boolean = false;
      
      public function BattleRoyalePlatoonRenderer()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(!this._isDisposed)
         {
            this.onDispose();
            this._isDisposed = true;
         }
      }
      
      public function getData() : Object
      {
         return undefined;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function setData(param1:Object) : void
      {
         if(this._platoonData && this._platoonData.isEqual(param1) || !param1)
         {
            return;
         }
         this.cleanUpData();
         this._platoonData = new BattleRoyalePlatoonVO(param1);
         this.icon.imageName = !!this._platoonData.isEnemy ? ENEMY : ALLY;
         visible = !this._platoonData.isDefaultData;
         alpha = !!this._platoonData.isDead ? Number(DESTROYED_ALPHA) : Number(DEFAULT_ALPHA);
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
      }
      
      protected function onDispose() : void
      {
         this.cleanUpData();
         this.icon = null;
         this._platoonData = null;
      }
      
      private function cleanUpData() : void
      {
         if(this._platoonData)
         {
            this._platoonData.dispose();
         }
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return undefined;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get displayFocus() : Boolean
      {
         return false;
      }
      
      public function set displayFocus(param1:Boolean) : void
      {
      }
      
      public function get focusTarget() : UIComponent
      {
         return undefined;
      }
      
      public function set focusTarget(param1:UIComponent) : void
      {
      }
      
      public function get UIID() : uint
      {
         return 0;
      }
      
      public function set UIID(param1:uint) : void
      {
      }
      
      public function handleInput(param1:InputEvent) : void
      {
      }
      
      public function validateNow(param1:Event = null) : void
      {
      }
   }
}
