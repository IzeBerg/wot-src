package net.wg.gui.lobby.questsWindow
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.Dictionary;
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
      
      private var _tasksPool:Object;
      
      private var _tasksDict:Dictionary;
      
      public function SubtasksList()
      {
         this.tasks = new Vector.<ISubtaskComponent>();
         this._data = [];
         this._tasksPool = {};
         this._tasksDict = new Dictionary(true);
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ISubtaskComponent = null;
         var _loc2_:* = null;
         if(this.tasks)
         {
            for each(_loc1_ in this.tasks)
            {
               _loc1_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
               _loc1_.dispose();
               removeChild(DisplayObject(_loc1_));
            }
            this.tasks = null;
         }
         if(this._tasksPool)
         {
            for(_loc2_ in this._tasksPool)
            {
               for each(_loc1_ in this._tasksPool[_loc2_])
               {
                  delete this._tasksDict[_loc1_];
                  _loc1_.dispose();
               }
               delete this._tasksPool[_loc2_];
            }
            this._tasksPool = null;
            this._tasksDict = null;
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
         var _loc2_:int = this.tasks.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.tasks[_loc3_];
            _loc1_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
            this.createTasksPool(_loc1_);
            removeChild(DisplayObject(_loc1_));
            _loc3_++;
         }
         this.tasks.splice(0,this.tasks.length);
      }
      
      private function createTasks() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:ISubtaskComponent = null;
         this.clearTasks();
         if(this._data)
         {
            _loc1_ = this._data.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._data[_loc2_];
               if(this._linkageSelector)
               {
                  _loc4_ = this._linkageSelector.getSpecialLinkage(_loc3_,_loc2_);
               }
               _loc5_ = !!StringUtils.isEmpty(_loc4_) ? this._linkage : _loc4_;
               _loc6_ = null;
               if(this._tasksPool[_loc5_] && this._tasksPool[_loc5_].length > 0)
               {
                  _loc6_ = this._tasksPool[_loc5_].pop();
               }
               else
               {
                  _loc6_ = App.utils.classFactory.getComponent(_loc5_,ISubtaskComponent);
               }
               _loc6_.addEventListener(Event.RESIZE,this.onTaskResizeHandler);
               _loc6_.setData(this._data[_loc2_]);
               _loc6_.validateNow();
               this.tasks.push(_loc6_);
               this._tasksDict[_loc6_] = _loc5_;
               addChild(DisplayObject(_loc6_));
               _loc2_++;
            }
         }
      }
      
      private function createTasksPool(param1:ISubtaskComponent) : void
      {
         var _loc2_:String = this._tasksDict[param1];
         if(this._tasksPool.hasOwnProperty(_loc2_))
         {
            this._tasksPool[_loc2_].push(param1);
         }
         else
         {
            this._tasksPool[_loc2_] = [param1];
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
