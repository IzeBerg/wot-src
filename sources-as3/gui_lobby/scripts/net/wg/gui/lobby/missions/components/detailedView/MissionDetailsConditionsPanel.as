package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.missions.data.MissionConditionsContainerVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class MissionDetailsConditionsPanel extends UIComponentEx
   {
      
      private static const MIN_CONDITIONS_TOP_OFFSET:Number = 140;
      
      private static const CONDITIONS_TOP_OFFSET:Number = 160;
      
      private static const TOKENS_CONDITIONS_TOP_OFFSET:Number = 145;
      
      private static const CONTAINER_WIDTH:int = 650;
       
      
      private var _conditionsContainers:Vector.<IUpdatableComponent>;
      
      public function MissionDetailsConditionsPanel()
      {
         this._conditionsContainers = new Vector.<IUpdatableComponent>();
         super();
      }
      
      override protected function onDispose() : void
      {
         this.cleanUpConditions();
         this._conditionsContainers = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<MissionConditionsContainerVO>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:MissionConditionsContainerVO = null;
         var _loc6_:IUpdatableComponent = null;
         this.cleanUpConditions();
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         if(_loc2_ > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = param1[_loc4_];
               _loc6_ = App.utils.classFactory.getComponent(_loc5_.linkageBig,IUpdatableComponent);
               this._conditionsContainers.push(addChild(DisplayObject(_loc6_)));
               _loc6_.width = CONTAINER_WIDTH;
               _loc6_.update(_loc5_);
               if(_loc3_ == 0)
               {
                  _loc3_ = this.getTopOffset(_loc5_.rendererLinkage);
               }
               _loc6_.validateNow();
               _loc6_.x = width - _loc6_.width >> 1;
               _loc6_.y = _loc3_;
               _loc3_ += _loc6_.height;
               _loc4_++;
            }
         }
      }
      
      private function getTopOffset(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case MISSIONS_ALIASES.TOKEN_CONDITION:
               _loc2_ = TOKENS_CONDITIONS_TOP_OFFSET;
               break;
            case MISSIONS_ALIASES.BATTLE_CONDITION_SMALL:
               _loc2_ = MIN_CONDITIONS_TOP_OFFSET;
               break;
            default:
               _loc2_ = CONDITIONS_TOP_OFFSET;
         }
         return _loc2_;
      }
      
      private function cleanUpConditions() : void
      {
         var _loc1_:IUpdatableComponent = null;
         if(this._conditionsContainers.length > 0)
         {
            for each(_loc1_ in this._conditionsContainers)
            {
               removeChild(DisplayObject(_loc1_));
               _loc1_.dispose();
            }
            this._conditionsContainers.splice(0,this._conditionsContainers.length);
         }
      }
   }
}
