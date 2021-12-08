package net.wg.gui.battle.views.consumablesPanel
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IEntityStateButton;
   import net.wg.infrastructure.managers.IAtlasManager;
   import scaleform.gfx.TextFieldEx;
   
   public class EntityStateButton extends BattleButton implements IEntityStateButton
   {
      
      private static const FIRST_MAN_POSTFIX:String = "1";
      
      private static const SECOND_MAN_POSTFIX:String = "2";
      
      private static const ENTITY_STATE_POSTFIX:String = "_orange";
      
      private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var icons:Sprite = null;
      
      public var bindKeyFieldNormal:TextField = null;
      
      public var bindKeyFieldCritical:TextField = null;
      
      public var bindKeyFieldDisabled:TextField = null;
      
      public var criticalFrame:Sprite = null;
      
      private var _consumablesVO:ConsumablesVO = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _entityName:String;
      
      private var _entityState:String = "normal";
      
      private var _bindSfKeyCode:int;
      
      public function EntityStateButton()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this._consumablesVO = new ConsumablesVO();
         this.unVisibleAll();
         this.bindKeyFieldNormal.visible = true;
         state = InteractiveStates.UP;
         TextFieldEx.setNoTranslate(this.bindKeyFieldNormal,true);
         TextFieldEx.setNoTranslate(this.bindKeyFieldCritical,true);
         TextFieldEx.setNoTranslate(this.bindKeyFieldDisabled,true);
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVO;
      }
      
      private function unVisibleAll() : void
      {
         this.bindKeyFieldNormal.visible = false;
         this.bindKeyFieldCritical.visible = false;
         this.bindKeyFieldDisabled.visible = false;
         this.criticalFrame.visible = false;
      }
      
      public function set entityName(param1:String) : void
      {
         if(param1 == this._entityName)
         {
            return;
         }
         this._entityName = param1;
         this.showIcon(this.icons,this._entityName);
      }
      
      public function set entityState(param1:String) : void
      {
         if(param1 == this._entityState)
         {
            return;
         }
         if(param1 == Values.EMPTY_STR && (this._entityState == BATTLE_ITEM_STATES.NORMAL || this._entityState == BATTLE_ITEM_STATES.CRITICAL))
         {
            this.icons.transform.colorTransform = COLOR_STATES.DISABLED_COLOR_TRANSFORM;
         }
         else if(this._entityState == Values.EMPTY_STR && (param1 == BATTLE_ITEM_STATES.NORMAL || param1 == BATTLE_ITEM_STATES.CRITICAL))
         {
            this.icons.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
         }
         this._entityState = param1;
         this.showIcon(this.icons,this._entityName);
         state = InteractiveStates.UP;
         this.unVisibleAll();
         if(this._entityState == BATTLE_ITEM_STATES.NORMAL)
         {
            this.bindKeyFieldNormal.visible = true;
            enabled = true;
         }
         else if(this._entityState == BATTLE_ITEM_STATES.CRITICAL)
         {
            this.bindKeyFieldCritical.visible = true;
            this.criticalFrame.visible = true;
            enabled = true;
         }
         else if(this._entityState == Values.EMPTY_STR)
         {
            this.bindKeyFieldDisabled.visible = true;
            enabled = false;
         }
      }
      
      public function set key(param1:int) : void
      {
         if(this._bindSfKeyCode == param1)
         {
            return;
         }
         this._bindSfKeyCode = param1;
         invalidate(KEY_VALIDATION);
      }
      
      private function showIcon(param1:Sprite, param2:String) : void
      {
         var _loc4_:String = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:String = this._entityState == BATTLE_ITEM_STATES.NORMAL ? Values.EMPTY_STR : ENTITY_STATE_POSTFIX;
         if(param2 == RolesState.LOADER + FIRST_MAN_POSTFIX || param2 == RolesState.LOADER + SECOND_MAN_POSTFIX)
         {
            _loc4_ = RolesState.LOADER + _loc3_;
         }
         else if(param2 == RolesState.GUNNER + FIRST_MAN_POSTFIX || param2 == RolesState.GUNNER + SECOND_MAN_POSTFIX)
         {
            _loc4_ = RolesState.GUNNER + _loc3_;
         }
         else if(param2 == RolesState.RADIOMAN + FIRST_MAN_POSTFIX || param2 == RolesState.RADIOMAN + SECOND_MAN_POSTFIX)
         {
            _loc4_ = RolesState.RADIOMAN + _loc3_;
         }
         else
         {
            _loc4_ = param2 + _loc3_;
         }
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc4_,param1.graphics);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(KEY_VALIDATION))
         {
            if(this._bindSfKeyCode == KeyProps.KEY_NONE)
            {
               _loc1_ = App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE_ALT);
            }
            else
            {
               _loc1_ = App.utils.commons.keyToString(this._bindSfKeyCode).keyName;
            }
            this.bindKeyFieldNormal.text = _loc1_;
            this.bindKeyFieldCritical.text = _loc1_;
            this.bindKeyFieldDisabled.text = _loc1_;
         }
      }
      
      override protected function configUI() : void
      {
         if(this._entityState)
         {
            state = InteractiveStates.UP;
         }
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.icons = null;
         this.bindKeyFieldNormal = null;
         this.bindKeyFieldCritical = null;
         this.bindKeyFieldDisabled = null;
         this.criticalFrame = null;
         this._consumablesVO = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
