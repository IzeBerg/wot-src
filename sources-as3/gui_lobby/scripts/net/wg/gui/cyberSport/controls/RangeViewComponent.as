package net.wg.gui.cyberSport.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.components.advanced.NationFlags25x17;
   import net.wg.gui.components.advanced.interfaces.IUILoaderBased;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   
   public class RangeViewComponent extends UIComponentEx
   {
      
      private static const UPDATE_ROSTER:String = "updateRoster";
      
      private static const PADDING_SEPARATOR:int = 3;
       
      
      private var _model:SettingRosterVO;
      
      private var _container:Sprite;
      
      private var _lastPadding:int = 0;
      
      private var _classFactory:IClassFactory = null;
      
      public function RangeViewComponent()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this._classFactory = App.utils.classFactory;
         this._container = new Sprite();
         this.addChild(this._container);
      }
      
      override protected function onDispose() : void
      {
         this.removeChild(this._container);
         this._container = null;
         this._model = null;
         this._classFactory = null;
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
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = this._model.vLevelRange;
         var _loc2_:Array = this._model.vTypeRange;
         this.componentDecorator(this._model.nationIDRange,CYBER_SPORT_ALIASES.ROSTER_FLAGS,[_loc2_,_loc1_],0);
         this.componentDecorator(_loc2_,CYBER_SPORT_ALIASES.ROSTER_TYPES,[_loc1_],-2);
         var _loc3_:Boolean = this.isArrayValuesExists(_loc1_);
         if(_loc3_ && _loc1_.length > 1)
         {
            _loc4_ = _loc1_[0];
            _loc5_ = _loc1_[1];
            if(_loc4_ == _loc5_)
            {
               this.componentDecorator([_loc4_],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
            else
            {
               this.componentDecorator([_loc4_],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
               this.componentDecorator([],CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR,null,0);
               this.componentDecorator([_loc5_],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
         }
         else if(_loc3_)
         {
            this.componentDecorator(_loc1_,CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
         }
         this._container.x = this._width - this._container.width >> 1;
      }
      
      private function componentDecorator(param1:Array = null, param2:String = null, param3:Array = null, param4:int = 0) : void
      {
         if(!this.isArrayValuesExists(param1) && param2 != CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR)
         {
            return;
         }
         this.classInitializator(param1,param2,param4);
         if(!this.isArrayValuesExists(param3))
         {
            return;
         }
         var _loc5_:int = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(this.isArrayValuesExists(param3[_loc6_]))
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
         var _loc5_:Class = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         if(this.isArrayValuesExists(param1))
         {
            if(param2 == CYBER_SPORT_ALIASES.ROSTER_FLAGS)
            {
               _loc5_ = NationFlags25x17;
            }
            else
            {
               _loc5_ = MovieClip;
            }
            _loc6_ = param1.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc4_ = this._classFactory.getComponent(param2,_loc5_);
               if(_loc4_ is IUILoaderBased)
               {
                  IUILoaderBased(_loc4_).setSource(param1[_loc7_]);
               }
               else
               {
                  _loc4_.gotoAndStop(param1[_loc7_]);
               }
               this._container.addChild(_loc4_);
               this.setComponentPosition(_loc4_,param3);
               _loc7_++;
            }
         }
         else
         {
            _loc4_ = this._classFactory.getComponent(param2,MovieClip);
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
            param1.x = _loc3_.x + _loc3_.width + param2 + this._lastPadding | 0;
         }
         else
         {
            param1.x = 0;
         }
         if(this._lastPadding != 0)
         {
            this._lastPadding = 0;
         }
         param1.y = this.height - param1.height >> 1;
      }
      
      private function isArrayValuesExists(param1:Array) : Boolean
      {
         return param1 && param1.length > 0;
      }
      
      private function createSeparator() : void
      {
         var _loc1_:MovieClip = this._classFactory.getComponent(CYBER_SPORT_ALIASES.ROSTER_SEPARATOR,MovieClip);
         this._container.addChild(_loc1_);
         this.setComponentPosition(_loc1_,PADDING_SEPARATOR);
         this._lastPadding = PADDING_SEPARATOR;
      }
   }
}
