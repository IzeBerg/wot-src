package net.wg.gui.lobby.questsWindow
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class SubtasksList extends UIComponentEx
   {
      
      private static const SUBTASKS_SIZE:String = "invSubtasksSize";
       
      
      protected var tasks:Vector.<ISubtaskComponent>;
      
      private var _data:Array;
      
      private var _linkage:String = "SubtaskComponent_UI";
      
      private var _linkageSelector:ISubtaskListLinkageSelector;
      
      public function SubtasksList()
      {
         this._data = [];
         super();
         this.tasks = new Vector.<ISubtaskComponent>();
      }
      
      override protected function onDispose() : void
      {
         if(this.tasks)
         {
            this.clearTasks();
            this.tasks = null;
         }
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         this._linkageSelector = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.createTasks();
            invalidate(SUBTASKS_SIZE);
         }
         if(isInvalid(SUBTASKS_SIZE))
         {
            this.layoutTasks();
         }
      }
      
      public function setData(param1:Array) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setLinkageSelector(param1:ISubtaskListLinkageSelector) : void
      {
         this._linkageSelector = param1;
      }
      
      protected function layoutTasks() : void
      {
         var _loc2_:ISubtaskComponent = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.tasks)
         {
            _loc2_.y = _loc1_;
            _loc1_ += _loc2_.height;
         }
         setSize(this.width,_loc1_);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function clearTasks() : void
      {
         var _loc1_:ISubtaskComponent = null;
         for each(_loc1_ in this.tasks)
         {
            _loc1_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
            _loc1_.dispose();
            removeChild(DisplayObject(_loc1_));
         }
         this.tasks.splice(0,this.tasks.length);
      }
      
      private function createTasks() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:ISubtaskComponent = null;
         var _loc8_:String = null;
         var _loc9_:ISubtaskComponent = null;
         if(this._data)
         {
            _loc1_ = this._data.length;
            if(this.tasks.length < _loc1_)
            {
               _loc3_ = _loc1_ - this.tasks.length;
               _loc4_ = this.tasks.length;
               _loc5_ = 0;
               while(_loc5_ < _loc3_)
               {
                  _loc6_ = this._data[_loc5_];
                  _loc7_ = null;
                  _loc8_ = null;
                  if(this._linkageSelector)
                  {
                     _loc8_ = this._linkageSelector.getSpecialLinkage(_loc6_,_loc5_);
                  }
                  if(StringUtils.isEmpty(_loc8_))
                  {
                     _loc8_ = this._linkage;
                  }
                  _loc7_ = App.utils.classFactory.getComponent(_loc8_,ISubtaskComponent);
                  _loc7_.addEventListener(Event.RESIZE,this.onTaskResizeHandler);
                  this.tasks.push(_loc7_);
                  addChild(DisplayObject(_loc7_));
                  _loc4_++;
                  _loc5_++;
               }
            }
            else if(this.tasks.length > _loc1_)
            {
               while(this.tasks.length > _loc1_)
               {
                  _loc9_ = this.tasks.pop();
                  _loc9_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
                  _loc9_.dispose();
                  removeChild(DisplayObject(_loc9_));
               }
            }
            _loc2_ = 0;
            while(_loc2_ < this._data.length)
            {
               this.tasks[_loc2_].setData(this._data[_loc2_]);
               this.tasks[_loc2_].validateNow();
               _loc2_++;
            }
         }
         else
         {
            this.clearTasks();
         }
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      private function onTaskResizeHandler(param1:Event) : void
      {
         invalidate(SUBTASKS_SIZE);
      }
   }
}
