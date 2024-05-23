package net.wg.gui.lobby.techtree.nodes
{
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   
   public class FakeNode extends Renderer
   {
       
      
      private var _children:Vector.<IRenderer>;
      
      private var _parents:Vector.<IRenderer>;
      
      private var _lastNodeState:String = "";
      
      public function FakeNode()
      {
         super();
      }
      
      override public function getInX() : Number
      {
         return x + Math.round(_width);
      }
      
      override public function getOutX() : Number
      {
         return x + Math.round(_width);
      }
      
      override public function isFake() : Boolean
      {
         return true;
      }
      
      override public function isNext2Unlock() : Boolean
      {
         var _loc1_:IRenderer = null;
         var _loc2_:uint = this._parents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._parents[_loc3_];
            if(_loc1_.isNext2Unlock())
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      override public function isUnlocked() : Boolean
      {
         var _loc1_:IRenderer = null;
         var _loc2_:uint = this._parents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._parents[_loc3_];
            if(_loc1_.isUnlocked())
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      override public function toString() : String
      {
         return "[FakeNode " + index + ", " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         this.clearChildren();
         this.clearParents();
         this._parents = null;
         this._children = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._parents = new Vector.<IRenderer>();
         this._children = new Vector.<IRenderer>();
      }
      
      public function setChildren(param1:Vector.<IRenderer>) : void
      {
         this.clearChildren();
         this._children = param1;
         var _loc2_:uint = this._children.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._children[_loc3_].addEventListener(TechTreeEvent.STATE_CHANGED,this.handleStateChanged,false,0,true);
            _loc3_++;
         }
      }
      
      public function getFirstChild() : IRenderer
      {
         return this._children.length > 0 ? this._children[0] : null;
      }
      
      public function setParents(param1:Vector.<IRenderer>) : void
      {
         this.clearParents();
         this._parents = param1;
         var _loc2_:uint = this._parents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._parents[_loc3_].addEventListener(TechTreeEvent.STATE_CHANGED,this.handleStateChanged,false,0,true);
            _loc3_++;
         }
      }
      
      private function validateNodeState(param1:String) : void
      {
         if(this._lastNodeState != param1)
         {
            this._lastNodeState = param1;
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED,param1,index));
         }
      }
      
      private function clearParents() : void
      {
         var _loc1_:IRenderer = null;
         while(this._parents.length > 0)
         {
            _loc1_ = this._parents.pop();
            _loc1_.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleStateChanged);
         }
      }
      
      private function clearChildren() : void
      {
         var _loc1_:IRenderer = null;
         while(this._children.length > 0)
         {
            _loc1_ = this._children.pop();
            _loc1_.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleStateChanged);
         }
      }
      
      private function handleStateChanged(param1:TechTreeEvent) : void
      {
         this.validateNodeState(param1.nodeState);
      }
   }
}
