/* Copyright 2010-2011 SpringSource.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @author <a href='mailto:burt@burtbeckwith.com'>Burt Beckwith</a>
 */

includeTargets << new File("$databaseMigrationPluginDir/scripts/_DatabaseMigrationCommon.groovy")

target(dbmGenerateChangelog: 'Generates an initial changelog XML file') {
	depends dbmInit

	if (!okToWrite(0, true)) return

	doAndClose {
		ScriptUtils.executeAndWrite argsList[0], booleanArg('add'), { PrintStream out ->
			ScriptUtils.createDiff(database, null, appCtx, diffTypes).compare().printChangeLog out, database
		}
	}
}

setDefaultTarget dbmGenerateChangelog
