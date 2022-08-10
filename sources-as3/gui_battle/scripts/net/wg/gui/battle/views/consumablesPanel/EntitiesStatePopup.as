package net.wg.gui.battle.views.consumablesPanel
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IEntityStateButton;
   import net.wg.utils.IClassFactory;
   
   public class EntitiesStatePopup extends BattleUIComponent
   {
      
      private static const ENTITY_PADDING_X:int = 5;
      
      private static const ENTITY_PADDING_Y:int = 2;
      
      private static const ENTITY_X:int = 48;
       
      
      private var _data:Array;
      
      private var _renderers:Vector.<EntityStateButton>;
      
      private var _clickButtonHandler:IClickButtonHandler = null;
      
      private var _classFactory:IClassFactory;
      
      public function EntitiesStatePopup()
      {
         this._renderers = new Vector.<EntityStateButton>();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EntityStateButton = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.dispose();
         }
         this._renderers.splice(0,this._renderers.length);
         this._renderers = null;
         this._data = null;
         this._clickButtonHandler = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function addClickHandler(param1:IClickButtonHandler) : void
      {
         this._clickButtonHandler = param1;
      }
      
      public function createPopup(param1:Array) : void
      {
         var _loc2_:EntityStateButton = null;
         var _loc3_:int = param1.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._classFactory.getComponent(Linkages.ENTITY_BUTTON,EntityStateButton);
            addChild(_loc2_);
            _loc2_.x = _loc4_ * ENTITY_X + ENTITY_PADDING_X;
            _loc2_.y = ENTITY_PADDING_Y;
            this._renderers.push(_loc2_);
            _loc4_++;
         }
         this.setData(param1);
      }
      
      public function setData(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:IEntityStateButton = null;
         this._data = param1;
         var _loc5_:int = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = this._data[_loc6_];
            _loc2_ = Boolean(_loc3_.entityState) ? _loc3_.entityState : Values.EMPTY_STR;
            _loc4_ = this._renderers[_loc6_] as IEntityStateButton;
            App.utils.asserter.assertNotNull(_loc4_,"renderer" + Errors.CANT_NULL);
            if(_loc2_ == BATTLE_ITEM_STATES.DESTROYED)
            {
               _loc2_ = BATTLE_ITEM_STATES.CRITICAL;
            }
            _loc4_.entityState = _loc2_;
            _loc4_.key = _loc3_.sfKeyCode;
            _loc4_.consumablesVO.keyCode = _loc3_.bwKeyCode;
            _loc4_.consumablesVO.idx = _loc3_.entityIdx;
            _loc4_.entityName = _loc3_.entityName;
            if(this._clickButtonHandler)
            {
               _loc4_.addClickCallBack(this._clickButtonHandler);
            }
            _loc6_++;
         }
      }
      
      public function updateData(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = this._data.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if(this._data[_loc5_].entityName == param1)
            {
               this._data[_loc5_].entityState = param2;
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            this.setData(this._data);
         }
      }
   }
}
