package net.wg.gui.lobby.missions.components
{
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.missions.data.ConditionRendererVO;
   import net.wg.gui.lobby.missions.data.MissionConditionsContainerVO;
   import net.wg.gui.lobby.missions.data.MissionDetailsTokenRendererVO;
   import net.wg.gui.lobby.missions.data.TokenRendererVO;
   import net.wg.gui.lobby.missions.interfaces.IConditionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   
   public class MissionConditionsListContainer extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const RENDERER_HEIGHT:int = 76;
      
      private static const RENDERERS_VERTICAL_GAP:int = 15;
      
      private static const MAX_RENDERERS_IN_ROW:int = 3;
       
      
      public var list:SimpleTileList;
      
      private var _conditions:DataProvider;
      
      private var _listData:MissionConditionsContainerVO;
      
      public function MissionConditionsListContainer()
      {
         this._conditions = new DataProvider();
         super();
         visible = false;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.list = new SimpleTileList();
         addChild(this.list);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.list.directionMode = DirectionMode.HORIZONTAL;
         this.list.setSize(width,height);
         this.list.mouseChildren = true;
         this.list.addEventListener(Event.RESIZE,this.onListResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.list.removeEventListener(Event.RESIZE,this.onListResizeHandler);
         this.cleanUpConditions();
         this._conditions = null;
         this.list.dispose();
         this.list = null;
         this._listData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applyLayout();
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc5_:IConditionVO = null;
         this._listData = MissionConditionsContainerVO(param1);
         this.list.renderersAlign = !!this._listData.isDetailed ? SimpleTileList.RENDERERS_ALIGN_LEFT : SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.list.itemRenderer = App.utils.classFactory.getClass(this._listData.rendererLinkage);
         var _loc3_:Array = this._listData.data as Array;
         App.utils.asserter.assertNotNull(_loc3_ is Array,Errors.INVALID_TYPE + "Array");
         this.cleanUpConditions();
         var _loc4_:Boolean = this.useWideTextField(_loc3_);
         for each(_loc2_ in _loc3_)
         {
            _loc5_ = this.getData(this._listData.rendererLinkage,_loc2_);
            this._conditions.push(_loc5_);
            _loc5_.useWideTextField = _loc4_;
         }
         this.list.dataProvider = this._conditions;
         this.list.validateNow();
         invalidateData();
      }
      
      protected function useWideTextField(param1:Array) : Boolean
      {
         return param1.length == 1;
      }
      
      protected function applyLayout() : void
      {
         var _loc5_:UIComponent = null;
         var _loc1_:int = this.list.length;
         var _loc2_:int = _loc1_ > MAX_RENDERERS_IN_ROW ? int(MAX_RENDERERS_IN_ROW) : int(_loc1_);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = UIComponent(this.list.getRendererAt(_loc4_));
            _loc5_.validateNow();
            _loc3_ += _loc5_.width;
            _loc4_++;
         }
         this.list.tileWidth = _loc3_ / _loc2_ ^ 0;
         this.list.tileHeight = RENDERER_HEIGHT;
         this.list.horizontalGap = (this.list.width - _loc3_) / _loc2_ ^ 0;
         this.list.verticalGap = RENDERERS_VERTICAL_GAP;
         this.list.validateNow();
         width = _loc3_ + (_loc2_ - 1) * this.list.horizontalGap;
         height = _loc1_ / _loc2_ * (RENDERER_HEIGHT + RENDERERS_VERTICAL_GAP) - RENDERERS_VERTICAL_GAP;
         visible = true;
      }
      
      private function getData(param1:String, param2:Object) : IConditionVO
      {
         if(param1 == MISSIONS_ALIASES.BATTLE_CONDITION || param1 == MISSIONS_ALIASES.MINIMIZED_BATTLE_CONDITION || param1 == MISSIONS_ALIASES.BATTLE_CONDITION_SMALL)
         {
            return new ConditionRendererVO(param2);
         }
         if(param1 == MISSIONS_ALIASES.MINIMIZED_TOKEN_CONDITION)
         {
            return new TokenRendererVO(param2);
         }
         if(param1 == MISSIONS_ALIASES.TOKEN_CONDITION)
         {
            return new MissionDetailsTokenRendererVO(param2);
         }
         DebugUtils.LOG_ERROR(param1 + Errors.WASNT_FOUND);
         return null;
      }
      
      private function cleanUpConditions() : void
      {
         var _loc1_:IDisposable = null;
         if(this._conditions.length > 0)
         {
            for each(_loc1_ in this._conditions)
            {
               _loc1_.dispose();
            }
            this._conditions.cleanUp();
         }
      }
      
      private function onListResizeHandler(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}
