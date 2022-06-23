package net.wg.gui.cyberSport.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class RangeViewComponent extends UIComponentEx
   {
      
      private static const UPDATE_ROSTER:String = "updateRoster";
      
      private static const PADDING_SEPARATOR:int = 3;
       
      
      private var _model:SettingRosterVO;
      
      private var _container:Sprite;
      
      private var _lastPadding:int = 0;
      
      public function RangeViewComponent()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this._container = new Sprite();
         this.addChild(this._container);
      }
      
      override protected function onDispose() : void
      {
         this.removeChild(this._container);
         this._container = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_ROSTER) && this._model)
         {
            this.cleanContainer();
            this.initializeComponents();
         }
      }
      
      public function setData(param1:SettingRosterVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._model = param1;
         invalidate(UPDATE_ROSTER);
      }
      
      private function cleanContainer() : void
      {
         while(this._container.numChildren > 0)
         {
            this._container.removeChildAt(0);
         }
      }
      
      private function initializeComponents() : void
      {
         this.componentDecorator(this._model.nationIDRange,CYBER_SPORT_ALIASES.ROSTER_FLAGS,[this._model.vTypeRange,this._model.vLevelRange],0);
         this.componentDecorator(this._model.vTypeRange,CYBER_SPORT_ALIASES.ROSTER_TYPES,[this._model.vLevelRange],-2);
         if(this.checkArrayRosters(this._model.vLevelRange) && this._model.vLevelRange.length > 1)
         {
            if(this._model.vLevelRange[0] == this._model.vLevelRange[1])
            {
               this.componentDecorator([this._model.vLevelRange[0]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
            else
            {
               this.componentDecorator([this._model.vLevelRange[0]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
               this.componentDecorator([],CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR,null,0);
               this.componentDecorator([this._model.vLevelRange[1]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
         }
         else if(this.checkArrayRosters(this._model.vLevelRange))
         {
            this.componentDecorator(this._model.vLevelRange,CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
         }
         this._container.x = Math.round((this._width - this._container.width) / 2);
      }
      
      private function componentDecorator(param1:Array = null, param2:String = null, param3:Array = null, param4:int = 0) : void
      {
         if(!this.checkArrayRosters(param1) && param2 != CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR)
         {
            return;
         }
         this.classInitializator(param1,param2,param4);
         if(!this.checkArrayRosters(param3))
         {
            return;
         }
         var _loc5_:int = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(this.checkArrayRosters(param3[_loc6_]))
            {
               this.createSeparator();
               break;
            }
            _loc6_++;
         }
      }
      
      private function classInitializator(param1:Array = null, param2:String = null, param3:int = 0) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         if(param1 && param1.length > 0)
         {
            _loc5_ = param1.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = this.classFactory(param2);
               _loc4_.gotoAndStop(param1[_loc6_]);
               this._container.addChild(_loc4_);
               this.setComponentPosition(_loc4_,param3);
               _loc6_++;
            }
         }
         else
         {
            _loc4_ = this.classFactory(param2);
            this._container.addChild(_loc4_);
            this.setComponentPosition(_loc4_,param3);
         }
      }
      
      private function setComponentPosition(param1:DisplayObject, param2:int = 0) : void
      {
         var _loc3_:DisplayObject = null;
         if(this._container.numChildren > 1)
         {
            _loc3_ = this._container.getChildAt(this._container.numChildren - 2);
            param1.x = Math.round(_loc3_.x + _loc3_.width + param2 + this._lastPadding);
         }
         else
         {
            param1.x = 0;
         }
         if(this._lastPadding != 0)
         {
            this._lastPadding = 0;
         }
         param1.y = Math.round((this.height - param1.height) / 2);
      }
      
      private function checkArrayRosters(param1:Array) : Boolean
      {
         return param1 && param1.length > 0;
      }
      
      private function createSeparator() : void
      {
         var _loc1_:MovieClip = this.classFactory(CYBER_SPORT_ALIASES.ROSTER_SEPARATOR);
         this._container.addChild(_loc1_);
         this.setComponentPosition(_loc1_,PADDING_SEPARATOR);
         this._lastPadding = PADDING_SEPARATOR;
      }
      
      private function classFactory(param1:String) : *
      {
         return App.utils.classFactory.getComponent(param1,MovieClip);
      }
   }
}
