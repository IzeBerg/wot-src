package net.wg.infrastructure.managers.impl
{
   import flash.display.Loader;
   import net.wg.infrastructure.base.meta.impl.CacheManagerMeta;
   import net.wg.infrastructure.managers.ICacheManager;
   
   public class CacheManager extends CacheManagerMeta implements ICacheManager
   {
      
      public static var MSEC_IN_MIN:int = 60000;
      
      public static var BYTES_IN_KB:int = 1024;
      
      public static var BYTES_IN_MB:int = BYTES_IN_KB * 1024;
       
      
      private var _settings:CacheSettings;
      
      private var cachedEntities:Vector.<CacheEntity>;
      
      private var _maxCacheBytes:int;
      
      private var maxIdleDuration:int;
      
      private var cacheStats:CacheStats;
      
      public function CacheManager()
      {
         super();
         this.cachedEntities = new Vector.<CacheEntity>();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._settings = new CacheSettings(getSettingsS());
         this._maxCacheBytes = this.settings.maxSize * BYTES_IN_MB;
         this.maxIdleDuration = this.settings.maxIdleDuration * MSEC_IN_MIN;
         if(this.settings.logging)
         {
            this.cacheStats = new CacheStats(this);
            this.cacheStats.logSettings();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = this.cachedEntities.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.cachedEntities[_loc2_].dispose();
            this.cachedEntities[_loc2_] = null;
            _loc2_++;
         }
         this.cachedEntities.splice(0,_loc1_);
         if(this.cacheStats)
         {
            if(this.settings.logging)
            {
               this.cacheStats.logSnapshots();
            }
            this.cacheStats.dispose();
         }
      }
      
      public function add(param1:String, param2:Loader, param3:Class = null) : Boolean
      {
         if(!this.settings.enabled || this.isExcluded(param1) && !this.settings.forceCache)
         {
            return false;
         }
         var _loc4_:CacheEntity = new CacheEntity(param1,param2,param3);
         if(_loc4_.size > this._maxCacheBytes)
         {
            DebugUtils.LOG_WARNING(CacheStats.LOG_ID + " Not enough memory for the caching: entity \'" + _loc4_.url + "\' wasn\'t cached.");
            _loc4_.dispose();
            this.lowerPriorities();
         }
         else
         {
            if(this.maxIdleDuration > 0 && this.getTotalSize() + _loc4_.size > this._maxCacheBytes)
            {
               this.freeByIdle(this.maxIdleDuration,_loc4_.size);
            }
            if(this.getTotalSize() + _loc4_.size > this._maxCacheBytes)
            {
               this.forcedFree(_loc4_.size);
            }
            this.lowerPriorities();
            this.cachedEntities.unshift(_loc4_);
         }
         if(this.settings.logging)
         {
            this.cacheStats.addEntity(_loc4_);
            this.cacheStats.addSnapshot(this.cachedEntities);
            this.cacheStats.logSnapshots();
            this.cacheStats.clean();
         }
         this.cachedEntities.sort(this.compareByPriority);
         return true;
      }
      
      public function getClassDef(param1:String, param2:Boolean = false) : Class
      {
         if(param2)
         {
            this.raisePriority(param1);
         }
         return this.getCacheEntity(param1).classDef;
      }
      
      public function get enabled() : Boolean
      {
         return this.settings && this.settings.enabled;
      }
      
      public function isCached(param1:String) : Boolean
      {
         if(this.isExcluded(param1))
         {
            return false;
         }
         var _loc2_:int = this.cachedEntities.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.cachedEntities[_loc3_].url == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function freeByIdle(param1:int, param2:int = 0) : Boolean
      {
         var _loc4_:CacheEntity = null;
         var _loc3_:int = 0;
         var _loc5_:Number = new Date().getTime();
         var _loc6_:int = this.cachedEntities.length;
         while(_loc3_ < param2 && _loc6_-- > 0)
         {
            _loc4_ = this.cachedEntities[_loc6_];
            if(param1 < _loc5_ - _loc4_.created)
            {
               _loc4_ = this.cachedEntities.pop();
               _loc3_ += _loc4_.size;
               if(this.settings.logging)
               {
                  this.cacheStats.removeEntity(_loc4_,true);
               }
               _loc4_.dispose();
            }
         }
         _loc4_ = null;
         return _loc3_ > param2 && !this.isEmpty;
      }
      
      private function forcedFree(param1:int) : Boolean
      {
         var _loc3_:CacheEntity = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1 && !this.isEmpty)
         {
            _loc3_ = this.cachedEntities.pop();
            _loc2_ += _loc3_.size;
            if(this.settings.logging)
            {
               this.cacheStats.removeEntity(_loc3_);
            }
            _loc3_.dispose();
         }
         _loc3_ = null;
         return this.cachedEntities.length > 0;
      }
      
      private function isExcluded(param1:String) : Boolean
      {
         return this.settings.excluded.indexOf(param1) > -1;
      }
      
      private function compareByPriority(param1:CacheEntity, param2:CacheEntity) : Number
      {
         var _loc3_:int = param1.priority;
         var _loc4_:int = param2.priority;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function getCacheEntity(param1:String) : CacheEntity
      {
         var _loc2_:int = -1;
         var _loc3_:int = this.cachedEntities.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.cachedEntities[_loc4_].url == param1)
            {
               _loc2_ = _loc4_;
               if(this.settings.logging)
               {
                  this.cacheStats.getEntity(this.cachedEntities[_loc2_]);
               }
               break;
            }
            _loc4_++;
         }
         return _loc2_ >= 0 ? this.cachedEntities[_loc2_] : null;
      }
      
      private function lowerPriorities() : void
      {
         var _loc1_:int = this.cachedEntities.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.cachedEntities[_loc2_].lowerPriority();
            _loc2_++;
         }
      }
      
      private function raisePriority(param1:String) : void
      {
         this.getCacheEntity(param1).raisePriority();
         this.cachedEntities.sort(this.compareByPriority);
      }
      
      public function get settings() : CacheSettings
      {
         return this._settings;
      }
      
      public function get isEmpty() : Boolean
      {
         return this.cachedEntities.length == 0;
      }
      
      public function getTotalSize() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.cachedEntities.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ += this.cachedEntities[_loc3_].size;
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

class CacheSettings
{
    
   
   public var enabled:Boolean = false;
   
   public var forceCache:Boolean = false;
   
   public var maxSize:int = 0;
   
   public var maxIdleDuration:Number = 0;
   
   public var excluded:Vector.<String>;
   
   public var logging:Boolean = false;
   
   function CacheSettings(param1:Object)
   {
      this.excluded = new Vector.<String>(0);
      super();
      if(param1)
      {
         this.enabled = true == param1["enabled"];
         this.forceCache = true == param1["forceCache"];
         if(this.forceCache)
         {
            DebugUtils.LOG_WARNING(CacheStats.LOG_ID + " forceCache mode is enabled.");
         }
         this.maxSize = parseInt(param1["maxSize"]);
         this.maxIdleDuration = Number(param1["maxIdleDuration"]);
         if(param1["excluded"])
         {
            this.excluded = this.excluded.concat(Vector.<String>(param1["excluded"]));
         }
         this.logging = true == param1["logging"];
      }
   }
   
   public function toString() : String
   {
      var _loc1_:String = "";
      _loc1_ += "\tenabled:\t" + String(this.enabled);
      _loc1_ += "\n\tforceCache:\t" + String(this.forceCache);
      _loc1_ += "\n\tmaxSize:\t" + String(this.maxSize) + " MB";
      _loc1_ += "\n\tmaxIdleDuration:\t" + String(this.maxIdleDuration) + " min";
      _loc1_ += "\n\texcluded:\t" + this.excluded.toString();
      return _loc1_ + "\n";
   }
   
   public function dispose() : void
   {
      this.excluded.splice(0,this.excluded.length);
   }
}

import flash.display.Loader;

class CacheEntity
{
    
   
   public var url:String;
   
   private var _priority:int;
   
   private var _loader:Loader;
   
   private var _classDef:Class;
   
   private var _created:Number;
   
   private var _size:int;
   
   function CacheEntity(param1:String, param2:Loader, param3:Class = null)
   {
      super();
      this.url = param1;
      this._priority = 0;
      this._loader = param2;
      this._classDef = param3;
      this._size = this.getSize(this._loader);
      this._created = new Date().getTime();
   }
   
   private function getSize(param1:Loader) : int
   {
      return int(param1.contentLoaderInfo.bytesLoaded);
   }
   
   public function raisePriority() : void
   {
      ++this._priority;
   }
   
   public function lowerPriority() : void
   {
      if(--this._priority < 0)
      {
         this._priority = 0;
      }
   }
   
   public function get priority() : int
   {
      return this._priority;
   }
   
   public function get size() : int
   {
      return this._size;
   }
   
   public function get created() : Number
   {
      return this._created;
   }
   
   public function get classDef() : Class
   {
      return this._classDef;
   }
   
   public function toString() : String
   {
      var _loc1_:Date = new Date(this.created);
      return "URL: " + this.url + ", priority: " + String(this.priority) + ", size: " + String(this.size) + ", class: " + (Boolean(this.classDef) ? this.classDef.toString() : "None") + ", created: " + String(_loc1_.getHours()) + ":" + String(_loc1_.getMinutes()) + ":" + String(_loc1_.getSeconds()) + "." + String(_loc1_.getMilliseconds());
   }
   
   public function dispose() : void
   {
      this.url = null;
      this._classDef = null;
      this._loader.close();
      this._loader.unloadAndStop();
      this._loader = null;
   }
}

import net.wg.infrastructure.managers.impl.CacheManager;

class CacheStats
{
   
   public static const LOG_ID:String = "[CacheManager]";
    
   
   private var cacheManager:CacheManager;
   
   private var snapshots:Vector.<String>;
   
   function CacheStats(param1:CacheManager)
   {
      super();
      this.cacheManager = param1;
      this.snapshots = new Vector.<String>();
   }
   
   public function addEntity(param1:CacheEntity) : void
   {
      var _loc2_:String = "\n" + LOG_ID;
      _loc2_ += " Entity was added to cache: \n";
      _loc2_ += "\t\t" + param1.toString();
      this.snapshots.push(_loc2_);
   }
   
   public function removeEntity(param1:CacheEntity, param2:Boolean = false) : void
   {
      var _loc3_:String = "\n" + LOG_ID;
      _loc3_ += !!param2 ? " Entity was removed from cache by idle: \n" : " Entity was removed from cache: \n";
      _loc3_ += "\t\t" + param1.toString();
      this.snapshots.push(_loc3_);
   }
   
   public function getEntity(param1:CacheEntity) : void
   {
      var _loc2_:String = "\n" + LOG_ID;
      _loc2_ += " Get entity from cache: \n";
      _loc2_ += "\t\t" + param1.toString();
      this.snapshots.push(_loc2_);
   }
   
   public function addSnapshot(param1:Vector.<CacheEntity>) : void
   {
      var _loc2_:String = "\n" + LOG_ID + " Cache snapshot: \n";
      var _loc3_:int = param1.length;
      var _loc4_:int = 0;
      while(_loc4_ < _loc3_)
      {
         _loc2_ += "\t\t" + param1[_loc4_].toString() + "\n";
         _loc4_++;
      }
      _loc2_ += "\n\tEntities total:\t" + String(param1.length);
      _loc2_ += "\n\tCache memory total:\t" + String(this.cacheManager.settings.maxSize) + " MB";
      _loc2_ += "\n\tCache memory used:\t" + String(this.cacheManager.getTotalSize() / CacheManager.BYTES_IN_MB) + " MB";
      _loc2_ += "\n";
      this.snapshots.push(_loc2_);
   }
   
   public function logSettings() : void
   {
      var _loc1_:String = null;
      if(this.cacheManager.settings)
      {
         _loc1_ = "\n" + LOG_ID + " Cache settings: \n";
         _loc1_ += this.cacheManager.settings.toString();
         DebugUtils.LOG_DEBUG(_loc1_);
         return;
      }
      throw new Error(LOG_ID + " The cache settings data is empty.");
   }
   
   public function logSnapshots() : void
   {
      var _loc3_:int = 0;
      var _loc1_:String = "";
      var _loc2_:int = this.snapshots.length;
      if(_loc2_ > 0)
      {
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ += this.snapshots[_loc3_];
            _loc3_++;
         }
      }
      else
      {
         _loc1_ += LOG_ID + " The cache is empty.";
      }
      DebugUtils.LOG_DEBUG(_loc1_);
   }
   
   public function clean() : void
   {
      this.snapshots.splice(0,this.snapshots.length);
   }
   
   public function dispose() : void
   {
      this.clean();
      this.cacheManager = null;
   }
}
