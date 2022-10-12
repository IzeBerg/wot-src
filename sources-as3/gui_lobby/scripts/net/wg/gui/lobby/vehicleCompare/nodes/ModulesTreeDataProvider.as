package net.wg.gui.lobby.vehicleCompare.nodes
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.data.AbstractDataProvider;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
   import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
   import net.wg.utils.ILocale;
   
   public class ModulesTreeDataProvider extends AbstractDataProvider implements IResearchDataProvider
   {
       
      
      private var _depthOfPaths:Vector.<Number>;
      
      public function ModulesTreeDataProvider()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         if(this._depthOfPaths)
         {
            this._depthOfPaths.splice(0,this._depthOfPaths.length);
            this._depthOfPaths = null;
         }
      }
      
      override public function parse(param1:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:NodeData = null;
         var _loc7_:ResearchDisplayInfo = null;
         this.cleanUp();
         this._depthOfPaths = new Vector.<Number>();
         NodeData.setDisplayInfoClass(ResearchDisplayInfo);
         var _loc2_:ILocale = App.utils.locale;
         var _loc3_:Array = param1 as Array;
         App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
         var _loc4_:uint = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new NodeData();
            _loc6_.fromObject(_loc3_[_loc5_],_loc2_);
            nodeIdxCache[_loc6_.id] = nodeData.length;
            nodeData.push(_loc6_);
            _loc7_ = _loc6_.displayInfo as ResearchDisplayInfo;
            this._depthOfPaths.push(_loc7_ != null ? _loc7_.getDepthOfPath() : 0);
            _loc5_++;
         }
      }
      
      override public function setState(param1:Number, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:Object = nodeData[param1];
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.state != param3;
            _loc5_.state = param3;
         }
         return _loc4_;
      }
      
      public function getDepthOfPath(param1:int) : Number
      {
         var _loc2_:Number = this._depthOfPaths[param1];
         return !!isNaN(_loc2_) ? Number(0) : Number(_loc2_);
      }
      
      public function getTopLevelAt(param1:int) : NodeData
      {
         return null;
      }
      
      public function getTopLevelIndexByID(param1:int) : Number
      {
         return -1;
      }
      
      public function populate(param1:ADG_ItemLevelsBuilder) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:ResearchDisplayInfo = null;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc2_:Array = param1.matrix;
         var _loc3_:uint = nodeData.length;
         var _loc10_:int = 0;
         while(_loc10_ < _loc3_)
         {
            _loc7_ = nodeData[_loc10_];
            _loc9_ = ResearchDisplayInfo(_loc7_.displayInfo);
            if(_loc9_.level > -1)
            {
               param1.addFixedPath(_loc10_,_loc9_.level);
            }
            _loc6_ = 0;
            _loc8_ = _loc9_.path;
            _loc12_ = _loc8_.length;
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _loc5_ = getIndexByID(_loc8_[_loc11_]);
               _loc6_ = Math.max(_loc6_,this.getDepthOfPath(_loc5_));
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _loc4_ = _loc8_[_loc11_];
               if(!(isNaN(_loc4_) || _loc4_ == 0))
               {
                  _loc5_ = getIndexByID(_loc4_);
                  if(!isNaN(_loc5_) && this.getDepthOfPath(_loc5_) == _loc6_)
                  {
                     _loc2_[_loc5_][_loc10_] = 1;
                     _loc2_[_loc10_][_loc5_] = -1;
                  }
               }
               _loc11_++;
            }
            _loc10_++;
         }
      }
      
      public function resolveEntityType(param1:NodeData, param2:Boolean = false) : uint
      {
         var _loc3_:uint = NodeEntityType.UNDEFINED;
         if(param1 != null)
         {
            _loc3_ = NodeEntityType.RESEARCH_ITEM;
         }
         return _loc3_;
      }
      
      public function setTopLevelField(param1:String, param2:Number, param3:Object) : Boolean
      {
         return false;
      }
      
      public function setTopLevelState(param1:Number, param2:Number, param3:Number) : Boolean
      {
         return false;
      }
      
      public function setTopLevelUnlockProps(param1:Number, param2:UnlockProps) : Boolean
      {
         return false;
      }
      
      public function setTopLevelXP(param1:Number, param2:Number) : Boolean
      {
         return false;
      }
      
      public function get topLength() : Number
      {
         return 0;
      }
   }
}
